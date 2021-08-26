Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531B73F869F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbhHZLmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241887AbhHZLmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:42:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23AEE60E99;
        Thu, 26 Aug 2021 11:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629978090;
        bh=LBgfhQTnK58QE02OSqoVohFHKyxhIEMkQjpkw7VwFNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LSK5WshPd07ZqlzKhT91KVSnyT84cSj/y4rzSFBrHzaoXhKOYYeyw36Jo8naH9yaL
         mwcvfm6BPjo8iJTBLevZfbx7uaCNNIEswzB/huQ6MfMstpGdoE/mNtFLUXAZliHHnN
         MTDzBwwnJrQf7USwn7XtunFCrICgsmaG/XVm2UOE=
Date:   Thu, 26 Aug 2021 13:41:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Yaqii wu <yaqii.wu@mediatek.com>
Subject: Re: [PATCH next v2 1/6] Revert "usb: xhci-mtk: relax TT periodic
 bandwidth allocation"
Message-ID: <YSd93+3D/PbacgsP@kroah.com>
References: <20210826025144.51992-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826025144.51992-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 10:51:39AM +0800, Chunfeng Yun wrote:
> As discussed in following patch:
> https://patchwork.kernel.org/patch/12420339
> 
> No need calculate number of uframes again, but should use value
> form check_sch_tt(), if we plan to remove extra CS, also can do
> it in check_sch_tt(). So revert this patch, and prepare to send
> new patch for it.
> 
> This reverts commit 548011957d1d72e0b662300c8b32b81d593b796e.
> 
> Cc: Ikjoon Jang <ikjn@chromium.org>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: no changes

This series does not apply to my tree at all now, can you please rebase
and resend?

thanks,

greg k-h
