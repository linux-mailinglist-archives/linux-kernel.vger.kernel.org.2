Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82B1354151
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhDEKxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232499AbhDEKxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:53:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86401613A5;
        Mon,  5 Apr 2021 10:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617620021;
        bh=l0e9s1dpY+QbZqKeVSavKbOxPxvM7v+brrMcRqFnR4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psPX0vh3NbjgQMeanq4mPwNeCR1L5FfrEoM/v53Co+ux86Yk/wuOuNe3cd+Il89lU
         WSyJ15cLqJxkoRTFTRB1LXtn6kXugnhCCB0popj17SYiAHMwMuR/Q2zpLF+isBzmQ1
         P+53ks6SIUoY89Rsp+3SCCj8/tSQ3PHWifO3zxkg=
Date:   Mon, 5 Apr 2021 12:53:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     zbr@ioremap.net, corbet@lwn.net, rikard.falkeborn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] w1: ds2438: adding support for calibration of
 current measurements
Message-ID: <YGrsMmsI+Pvadow3@kroah.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405105009.420924-1-sampaio.ime@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 07:50:00AM -0300, Luiz Sampaio wrote:
> The following patches aim to make a user able to calibrate the current measurement of the DS2438. This chip uses a offset register in page1, which is added to the current register to give the user the current measurement. If this value is wrong, the user will get an offset current value, even if the current is zero, for instance. This patch gives support for reading the page1 registers (including the offset register) and for writing to the offset register. The DS2438 datasheet shows a calibration routine, and with this patch, the user can do this quickly by writing the correct value to the offset register. This patch was tested on real hardware using a power supply and an electronic load.
> Please help to review this series of patches.

Please linewrap your text here :(

