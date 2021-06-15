Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBFD3A7F20
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhFON0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhFON0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:26:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC41E6145D;
        Tue, 15 Jun 2021 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623763453;
        bh=NFFT9XXX43WE7Brg3+uTp+Pn3ngNE/vZ2FvOW2J7SaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUXhEjrugWMhna/B6tdutuHT6BzXqLaA9Y7mLXZDntI7m4O6wfJK+bpB7PRP9CixQ
         R2W2un7YRpgBdFba1b1B+zIlal05euuSYk14O3D4C/41jst6vlvUNW97zqOnRJ5ABv
         eB+gLV0RxpYSvpZtdg1p6ZGqiaK1ffVkBWyrbZVs=
Date:   Tue, 15 Jun 2021 15:24:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] staging: rtl8723bs: remove include/autoconf.h header
 file from tree
Message-ID: <YMip+8CWBFAI40tf@kroah.com>
References: <cover.1623756906.git.fabioaiuto83@gmail.com>
 <9317fa8fd41da4668a41775207b5e6dad33e7447.1623756906.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9317fa8fd41da4668a41775207b5e6dad33e7447.1623756906.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 01:45:37PM +0200, Fabio Aiuto wrote:
> remove include/autoconf.h header file from tree.
> It just contains a compiler configuration check
> which is not needed.

It also still contains the LPS_RPWM_WAIT_MS define :(

