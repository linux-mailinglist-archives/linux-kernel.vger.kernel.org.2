Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42433F995F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245153AbhH0NLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232767AbhH0NLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:11:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B0D360F4F;
        Fri, 27 Aug 2021 13:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630069852;
        bh=c5+YHnWY7DrCFsFr+252fUHx97s4CmCD8ry0QtL+h4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYayoHH8cnQsGb3BQJeBWbDrfEEFMvQzpYNQrxweB/011kC6zcrTe0KOzMHFvvnbt
         iQnFh0If8StZnOZycShtpWVrr4LrsFMvLOaMvZYUTOQWhg+L8fCLEB2qmGGwuBP4B0
         mzzdSbSYz8wM8XMsqnGozo4bz1DcO2zwnlOmn2e0=
Date:   Fri, 27 Aug 2021 15:10:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wenlong Zhang <yixiaonn@gmail.com>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com, cyruscyliu@gmail.com,
        yajin@vm-kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] staging: rtl8723bs: prevent ->ssid overflow in
 rtw_wx_set_scan()
Message-ID: <YSjkVtvhgOgDq1qa@kroah.com>
References: <YSfjtZsISLH6cktF@kroah.com>
 <20210827125059.26694-1-yixiaonn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827125059.26694-1-yixiaonn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 08:50:59PM +0800, Wenlong Zhang wrote:
> Commit 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
> fixed up the staging driver rtl8188eu by adding another check
> to prevent writing beyond the end of the ->ssid[] array.
> 
> Resolve this by properly fixing up the rtl8723bs driver's version of
> rtw_wx_set_scan()
> 
> Fixes: 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
> Signed-off-by: Wenlong Zhang <yixiaonn@gmail.com>
> ---
> v3:
> - Added the changelogs for this patch.
> v2: 
> - Fixed the description of this patch.
>   Thanks Greg KH for the review and guidance

This doesn't apply against any tree that I can see.  Neither my
staging-next or the 5.14-rc6 kernel release.

What did you make it against?  Please rebase and resend it against at
the very least, 5.14-rc6.

thanks,

greg k-h
