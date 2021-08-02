Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAF53DD1EF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhHBI1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232656AbhHBI1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:27:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 659E261057;
        Mon,  2 Aug 2021 08:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627892844;
        bh=XGSf0Q2b9xJVK/A4yp1rTziqZAcP1MUIQ1F6Vv40gpc=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=fpoyIdteEGyBEqTxCBoxuEO2MZaDU5G05LwVpUbAUPBECxHH3LCLyZChnUz36BYyu
         cDoaHquy6XL5tqNFo9hALgObFAuUAPA+56+w0TFhPljDwcBvWVPJUzKehGSrlR8Z8W
         yJAB95FlvVLTb8qpaVK/oxqaKtH7SXeIK+gQ2mY6sjb1xS0F43fuj63ovmFYbnr8G3
         E1PD6mN27VCE1uMvLcWLdAhIcPZijx3cs2n7PdDg/J60+UFxtdBo3pfOYQUtQkdcjW
         mzeufP19hbZU9JC22lp4pylwP1k0/17DA19Fii6rRKdJZzsW5OsLCJmxiUdwS1VfaV
         wYUBF+oBUUpog==
References: <20210731171838.GA912463@pc>
User-agent: mu4e 1.6.0; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>,
        Jack Pham <jackp@codeaurora.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        kernel test robot <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dean Anderson <dean@sensoray.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Vamsi Krishna Samavedam <vskrishn@codeaurora.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: remove useless cast
Date:   Mon, 02 Aug 2021 11:26:54 +0300
In-reply-to: <20210731171838.GA912463@pc>
Message-ID: <877dh4s13r.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Salah Triki <salah.triki@gmail.com> writes:

> Remove the cast done by ERR_PTR() and PTR_ERR() since data is of type char
> * and fss_prepare_buffer() should returns a value of this type.
>
> Signed-off-by: Salah Triki <salah.triki@gmail.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
