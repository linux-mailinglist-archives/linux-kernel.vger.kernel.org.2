Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E513443D84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhKCHGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:06:04 -0400
Received: from nautica.notk.org ([91.121.71.147]:52664 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232034AbhKCHGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:06:01 -0400
X-Greylist: delayed 27910 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Nov 2021 03:05:59 EDT
Received: by nautica.notk.org (Postfix, from userid 108)
        id A27A5C009; Wed,  3 Nov 2021 08:03:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1635922997; bh=3m8R8rVPzcOA9Kl+sPidNtixAK7CoaPvD/KCTUeBcTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yxaYyOsjsFIKmM1Y8MTypkHz1t4PcwrWoKtT0NXupWUto9ecjp3ybW23C75y4p4Yb
         e84FqJtjfM8fbmtWmZbkUg50wXDmMbYAE2Go4UlPshPn4cgZVgBMng8ysjzj6WDQA/
         R2Vey7elBuZKbk0wFj6g31kaxvETTD80ydHFbz4vDUj6e+rwCKX4fJg1HoE5gjYoiO
         ZI8lbtnUKHLxVUM2IaPgOolRv1BHX5ymUeEGujp317GwPA5hBwTYNP1RmBg4av2XYy
         2ZTdCjJtD1KErp8kTxZej9XiA6LsdkH6UoVWGJq6rqsQ69mmwHS2VGVNX4hcGulosA
         CUoBE9WPv/ALg==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 503DDC009;
        Wed,  3 Nov 2021 08:03:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1635922997; bh=3m8R8rVPzcOA9Kl+sPidNtixAK7CoaPvD/KCTUeBcTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yxaYyOsjsFIKmM1Y8MTypkHz1t4PcwrWoKtT0NXupWUto9ecjp3ybW23C75y4p4Yb
         e84FqJtjfM8fbmtWmZbkUg50wXDmMbYAE2Go4UlPshPn4cgZVgBMng8ysjzj6WDQA/
         R2Vey7elBuZKbk0wFj6g31kaxvETTD80ydHFbz4vDUj6e+rwCKX4fJg1HoE5gjYoiO
         ZI8lbtnUKHLxVUM2IaPgOolRv1BHX5ymUeEGujp317GwPA5hBwTYNP1RmBg4av2XYy
         2ZTdCjJtD1KErp8kTxZej9XiA6LsdkH6UoVWGJq6rqsQ69mmwHS2VGVNX4hcGulosA
         CUoBE9WPv/ALg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 795e0252;
        Wed, 3 Nov 2021 07:03:12 +0000 (UTC)
Date:   Wed, 3 Nov 2021 16:02:57 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the v9fs tree
Message-ID: <YYI0IfG6lO83of3J@codewreck.org>
References: <20211103171115.1694cd05@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211103171115.1694cd05@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote on Wed, Nov 03, 2021 at 05:11:15PM +1100:
> Commit
> 
>   33b741d6c4f9 ("fixup! 9p: Convert to using the netfs helper lib to do reads and caching")
> 
> is missing a Signed-off-by from its author and committer.

Argh, I planned on squashing it after David had a chance to see it but
that was bad practice, sorry - cleaned up.

Thanks for the heads up!
-- 
Dominique

