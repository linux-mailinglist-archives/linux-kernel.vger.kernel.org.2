Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06D23328D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhCIOna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:43:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:51400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhCIOnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:43:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3221865239;
        Tue,  9 Mar 2021 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615301002;
        bh=5VR1ZEi5nxO1w9B3Wf+HqcUWf+DfqKqdpstKfB2Cp7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hh9t7o3VAC6JORBYSif55Cl1c456tnG76bnYiAv7Jr0SDGPNxT8bCk/MDTKBNq9NF
         TrMrMz/vpp5rqK+x4h3h50g9SiFVve/zOx7tmjyCOgDeIlI5AE5KRJ0+z9bWIfETU+
         MU/gqHhDMBik4zwYu+SaNmeOIAodoEKxqKKUqed0=
Date:   Tue, 9 Mar 2021 15:43:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Selvakumar Elangovan <selvakumar16197@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtl8712: fixed whitespace coding style issue
Message-ID: <YEeJh8xNXlv5yL+J@kroah.com>
References: <20210309141721.16772-1-selvakumar16197@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309141721.16772-1-selvakumar16197@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 07:47:21PM +0530, Selvakumar Elangovan wrote:
> Removed additional whitespaces in the rtl8712_xmit.h file.
> 
> Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl8712_xmit.h | 3 ---
>  1 file changed, 3 deletions(-)

What changed from v1?  Always put that below the --- line.

v3?

thanks,

greg k-h
