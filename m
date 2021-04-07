Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAF1356204
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344435AbhDGDjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:39:01 -0400
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:33612 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234337AbhDGDi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:38:58 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8704E181D337B;
        Wed,  7 Apr 2021 03:38:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 6CCE6C4182;
        Wed,  7 Apr 2021 03:38:47 +0000 (UTC)
Message-ID: <b56a44542a338583279893870ec819d4b1b4e23b.camel@perches.com>
Subject: Re: [PATCH][next] erofs: fix uninitialized variable i used in a
 while-loop
From:   Joe Perches <joe@perches.com>
To:     Gao Xiang <hsiangkao@redhat.com>,
        Colin King <colin.king@canonical.com>
Cc:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 06 Apr 2021 20:38:44 -0700
In-Reply-To: <20210406235401.GA210667@xiangao.remote.csb>
References: <20210406162718.429852-1-colin.king@canonical.com>
         <20210406235401.GA210667@xiangao.remote.csb>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Stat-Signature: ofx9em7xwsozzieswcpenrt3r3r95cat
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 6CCE6C4182
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19GKTF9FPXA2XYpIjjRK9qyadDR5X8MmkM=
X-HE-Tag: 1617766727-223981
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-04-07 at 07:54 +0800, Gao Xiang wrote:
> Hi Colin,
> 
> On Tue, Apr 06, 2021 at 05:27:18PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The while-loop iterates until src is non-null or i is 3, however, the
> > loop counter i is not intinitialied to zero, causing incorrect iteration
> > counts.  Fix this by initializing it to zero.
> > 
> > Addresses-Coverity: ("Uninitialized scalar variable")
> > Fixes: 1aa5f2e2feed ("erofs: support decompress big pcluster for lz4 backend")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Thank you very much for catching this! It looks good to me,
> Reviewed-by: Gao Xiang <hsiangkao@redhat.com>
> 
> (btw, may I fold this into the original patchset? since such big pcluster
>  patchset is just applied to for-next for further integration testing, and
>  the commit id is not stable yet..)
> 
> Thanks,
> Gao Xiang

I think this code is odd and would be more intelligible using
a for loop like:
---
 fs/erofs/decompressor.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 27aa6a99b371..5a64f4649414 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -286,28 +286,24 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	}
 
 	ret = alg->prepare_destpages(rq, pagepool);
-	if (ret < 0) {
+	if (ret < 0)
 		return ret;
-	} else if (ret) {
+	if (ret) {
 		dst = page_address(*rq->out);
 		dst_maptype = 1;
 		goto dstmap_out;
 	}
 
-	i = 0;
-	while (1) {
+	for (i = 0; i < 3; i++) {
 		dst = vm_map_ram(rq->out, nrpages_out, -1);
-
+		if (dst) {
+			dst_maptype = 2;
+			goto dstmap_out;
+		}
 		/* retry two more times (totally 3 times) */
-		if (dst || ++i >= 3)
-			break;
 		vm_unmap_aliases();
 	}
-
-	if (!dst)
-		return -ENOMEM;
-
-	dst_maptype = 2;
+	return -ENOMEM;
 
 dstmap_out:
 	ret = alg->decompress(rq, dst + rq->pageofs_out);

