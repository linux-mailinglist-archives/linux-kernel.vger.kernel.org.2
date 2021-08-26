Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F4F3F856B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbhHZKiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233929AbhHZKit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:38:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40EDE6108E;
        Thu, 26 Aug 2021 10:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629974282;
        bh=VnfV2BVfaslmfYlEK9+6jV7Vwu0OBzuNc8ALqlT2AFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwOz/TevojjD8DdKYxYawLvUrvisCvSXi04MS1ScZJ5Rv12spUOBsDasy94UmBdNp
         boT9NA9h8zelDFzIcLjX3OUipPoPj0WJ1y0sGQCdgVmTTMYLiWpu9mLesJ1Qli4Bhv
         qYO9WaBVpkGHUuRbICn5IyFF0eL0EYZpZY4UV/tw=
Date:   Thu, 26 Aug 2021 12:37:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] staging: r8188eu: add helper macro for printing
 registers
Message-ID: <YSdvBlNlScsuPnbz@kroah.com>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <84e388b0eaaf3c56f575216b0571318ed799a4d2.1629789580.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e388b0eaaf3c56f575216b0571318ed799a4d2.1629789580.git.paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:27:20AM +0300, Pavel Skripkin wrote:
> There are a lof of places, where DBG_88E() is used to print register
> value. Since following patches change _rtw_read*() family
> prototypes, we can wrap printing registers into useful macro to avoid
> open-coding error checking like this:
> 
> 	u32 tmp;
> 	if (!rtw_read(&tmp))
> 		DBG("reg = %d\n", tmp);
> 
> So, added DBG_88E_REG{8,16,32} macros for printing register values.

No, please work to remove these messy things, do not add new ones.

Why is this ever needed?  And if it is, use the correct in-kernel debug
functions please.

thanks,

greg k-h
