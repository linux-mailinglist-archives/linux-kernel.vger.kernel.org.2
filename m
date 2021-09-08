Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA9E4036F0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348185AbhIHJdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347159AbhIHJd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:33:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6287560EB7;
        Wed,  8 Sep 2021 09:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631093541;
        bh=kyZod5Uc1ZbTFRMw0xuI4FS86MssJEarZW0AOUizngk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uECowZBjQIL4+ADxo4ESLNo4+7MTOg2gpu/p2wD+EhmLIQK0caF83MKjrfPp9HpzT
         d6R+d+SCwGeDh7iSyjGyMikRhXkAGmeuO0DlylFadT2tz5osjqjO1r8CrjLQr8eTln
         tu19pfPIzY22chMQuasS1tQGQjWZHoG7zkuXTcIY=
Date:   Wed, 8 Sep 2021 11:32:19 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?7KCV64yA7ZmY?= <dh10.jung@samsung.com>
Cc:     "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: usb: gadget: u_serial: check Null pointer in EP callback
Message-ID: <YTiDI175BIv6RQ3c@kroah.com>
References: <20210908073235.GA13332@ubuntu>
 <1628236406-185160-1-git-send-email-dh10.jung@samsung.com>
 <YQzu+Xy+3wAyXeDK@kroah.com>
 <000001d7a482$93438b20$b9caa160$@samsung.com>
 <CGME20210806080835epcas2p2134b8b635e27d129a9e2f2f400a814fc@epcms2p3>
 <20210908075413epcms2p3e027c0b06cff30759aaf65bcc830b1f4@epcms2p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210908075413epcms2p3e027c0b06cff30759aaf65bcc830b1f4@epcms2p3>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 04:54:13PM +0900, 정대환 wrote:

<snip>

Please do not send html email, it is rejected by the mailing lists.
Please fix your email client and resend.

thanks,

greg k-h
