Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE337352DDC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbhDBQnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 12:43:23 -0400
Received: from verein.lst.de ([213.95.11.211]:44266 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhDBQnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 12:43:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B1B3C68BEB; Fri,  2 Apr 2021 18:43:18 +0200 (CEST)
Date:   Fri, 2 Apr 2021 18:43:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: disallow passthru cmd from targeting a nsid
 != nsid of the block dev
Message-ID: <20210402164318.GA21840@lst.de>
References: <20210326194749.396599-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210326194749.396599-1-Niklas.Cassel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 07:48:00PM +0000, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> When a passthru command targets a specific namespace, the ns parameter to
> nvme_user_cmd()/nvme_user_cmd64() is set. However, there is currently no
> validation that the nsid specified in the passthru command targets the
> namespace/nsid represented by the block device that the ioctl was
> performed on.
> 
> Add a check that validates that the nsid in the passthru command matches
> that of the supplied namespace.

git-am doesn't seem to like this patch:

pplying: nvme: disallow passthru cmd from targeting a nsid != nsid of the block
dev
error: invalid mode on line 2: 100644<br>
--- a/drivers/nvme/host/core.c<br>
+++ b/drivers/nvme/host/core.c<br>
@@ -1599,6 +1599,12 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct
nvme_ns *ns,<br>
                return -EFAULT;<br>
        if (cmd.flags)<br>
                return -EINVAL;<br>
+       if (ns &amp;&amp; cmd.nsid != ns-&gt;head-&gt;ns_id) {<br>
+               dev_err(ctrl-&gt;device,<br>
+                       &quot;%s: nsid (%u) in cmd does not match nsid (%u) of
namespace\n&quot;,<br>
+                       current-&gt;comm, cmd.nsid, ns-&gt;head-&gt;ns_id);<br>
+               return -EINVAL;<br>
+       }<br>
<br>
        memset(&amp;c, 0, sizeof(c));<br>
        c.common.opcode = cmd.opcode;<br>
@@ -1643,6 +1649,12 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl,
struct nvme_ns *ns,<br>
                return -EFAULT;<br>
        if (cmd.flags)<br>
                return -EINVAL;<br>
+       if (ns &amp;&amp; cmd.nsid != ns-&gt;head-&gt;ns_id) {<br>
+               dev_err(ctrl-&gt;device,<br>
+                       &quot;%s: nsid (%u) in cmd does not match nsid (%u) of
namespace\n&quot;,<br>
+                       current-&gt;comm, cmd.nsid, ns-&gt;head-&gt;ns_id);<br>
+               return -EINVAL;<br>
+       }<br>
<br>
        memset(&amp;c, 0, sizeof(c));<br>
        c.common.opcode = cmd.opcode;<br></blockquote></div></div><div
dir="auto"><br style="font-family:sans-serif;font-size:12.8px"><span
style="font-family:sans-serif;font-size:12.8px">Looks good.</span></div><div
dir="auto"><span style="font-family:sans-serif;font-size:12.8px">Reviewed-by:
Kanchan Joshi &lt;joshi.k</span><a href="mailto:javier@javigon.com"
style="text-decoration-line:none;color:rgb(66,133,244);font-family:sans-serif;font-size:12.8px">@samsung.com</a><span
style="font-family:sans-serif;font-size:12.8px">&gt;</span><br></div><div
dir="auto"><br></div><div dir="auto"><div class="gmail_quote"><blockquote
class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc
solid;padding-left:1ex"></blockquote></div></div></div>



