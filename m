Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B95A3F5B51
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhHXJvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbhHXJv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:51:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56582C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mw9iPdWggvtqmtwW5eY+Vz/Y0NmAThsEIjv37cm9I+Q=; b=WIx+LZoKhCVS84CzS3K3LZ7xC+
        Z2ShhhaOtrNzCrI67WDXuz9msUIKx5r1g1uernjAahPZeX896QZVQOV9Vvp9Yyl/emayU6wiIkBi3
        fgtYwHS+QEepDsQc/1UQrcAfczCS4QO3NkUkKGb5q760lMLRQBeEvNqpNRRMEixtncWrBhzwXOdM+
        TdlDDnZ+ayzxwJRMYLqCwQYawJAw77RRfIeAhTpbEyI4Vsaxf/etrWvIdaDxlLGfWmZmJHrtrL3bH
        XXOORgHuyF2ETPNyz2Gkh22kTHsXGfHsZGVo1qWTx+pVRZe8xzI1gKqxQZxCiDXIB4fqrTeAwWZx7
        hWJi98Gw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIT3W-00AryF-CX; Tue, 24 Aug 2021 09:49:29 +0000
Date:   Tue, 24 Aug 2021 10:49:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tawah Peggy <tawahpeggy98@gmail.com>
Cc:     Kroah-Hartman <greg@kroah.com>, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] [Outreachy Kernel] Staging: wlan-ng:
 cfg80211: Fix Lines should not end with a '('
Message-ID: <YSTAnuoGF4zuAFrg@casper.infradead.org>
References: <20210824031551.GA80985@peggy-InsydeH2O-EFI-BIOS>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824031551.GA80985@peggy-InsydeH2O-EFI-BIOS>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 04:15:51AM +0100, Tawah Peggy wrote:
> -			ieee80211_frequency_to_channel(
> -				request->channels[i]->center_freq);
> +			ieee80211_frequency_to_channel
> +				(request->channels[i]->center_freq);

This is the wrong way to fix this warning.  Function names should not be
divorced from their arguments.
