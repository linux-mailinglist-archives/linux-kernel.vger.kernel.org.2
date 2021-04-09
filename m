Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CA835958D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhDIGdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhDIGdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:33:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4496B610A3;
        Fri,  9 Apr 2021 06:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617950005;
        bh=yCdHBrN/kHGVkFYaO/eG0PB/iD92rmwVP1Z0FrCjlzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ioF3xfMTkks4yEir6PotK2ustLBZKIzKr68uaBkkatl/NyyhvKgtUR0ThK+pk++r2
         /RtmzlfVhBRIDX6fJLRyU6rqkMgazLzHJGxkyjsT3YMU5c9Hb2eKz30AsRZrx0N2TE
         1DEHL1xdvYH+Isui/ijjhLeCt18iOgq5D8NncP4E=
Date:   Fri, 9 Apr 2021 08:33:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergei Krainov <sergei.krainov.lkd@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: fix wrong function output
Message-ID: <YG/1MyfOrHgCi5sr@kroah.com>
References: <20210408234527.GA6893@test-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408234527.GA6893@test-VirtualBox>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 01:45:27AM +0200, Sergei Krainov wrote:
> Function r8712_find_network() were returning wlan_network even if it
> didn't match required address. This happened due to not checking if
> list end was reached and returning last processed wlan_network.
> 
> Signed-off-by: Sergei Krainov <sergei.krainov.lkd@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_mlme.c | 2 ++
>  1 file changed, 2 insertions(+)

What commit does this "fix"?  Or has this bug been there always?

thanks,

greg k-h
