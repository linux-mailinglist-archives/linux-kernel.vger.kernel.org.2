Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E774367DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhDVJ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhDVJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:27:17 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CE2C06174A;
        Thu, 22 Apr 2021 02:26:43 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZVbP-007H9U-Iu; Thu, 22 Apr 2021 09:26:27 +0000
Date:   Thu, 22 Apr 2021 09:26:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        John Wang <wangzhiqiang.bj@bytedance.com>,
        Brad Bishop <bradleyb@fuzziesquirrel.com>,
        Patrick Venture <venture@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Lippert <rlippert@google.com>,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] soc: aspeed: fix a ternary sign expansion bug
Message-ID: <YIFBQ50rcZO3NDFD@zeniv-ca.linux.org.uk>
References: <YIE90PSXsMTa2Y8n@mwanda>
 <YIFA68mfUTSMczp0@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIFA68mfUTSMczp0@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:24:59AM +0000, Al Viro wrote:
> On Thu, Apr 22, 2021 at 12:11:44PM +0300, Dan Carpenter wrote:
> > The intent here was to return negative error codes but it actually
> > returns positive values.  The problem is that type promotion with
> > ternary operations is quite complicated.
> > 
> > "ret" is an int.  "copied" is a u32.  And the snoop_file_read() function
> > returns long.  What happens is that "ret" is cast to u32 and becomes
> > positive then it's cast to long and it's still positive.
> > 
> > Fix this by removing the ternary so that "ret" is type promoted directly
> > to long.
> 
> Hmm...  Let's grep for kfifo_to_user() - smells like a possible recurring bug...
> Yup -
> 
> samples/kfifo/bytestream-example.c:138: ret = kfifo_to_user(&test, buf, count, &copied);
> samples/kfifo/inttype-example.c:131:    ret = kfifo_to_user(&test, buf, count, &copied);
> samples/kfifo/record-example.c:145:     ret = kfifo_to_user(&test, buf, count, &copied);
> 
> All three are exactly like that one.

Nevermind, you've already caught and posted that bunch.  Sorry for noise...
