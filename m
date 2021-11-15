Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8485452880
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbhKPDZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245394AbhKPDYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:24:11 -0500
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B780C04A53F;
        Mon, 15 Nov 2021 15:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YHeyfln0rHpbmKl/Xe8U2eW81LvOAY+qrUsDE7U5/zo=; b=KrcPJOfK5BBVvdUOp49OqeSUtD
        JhUnEeaa8NBbFDJdlyraE3bfRtQe1FU0DmF+IwFLUbyCK36Q2bkvSHIiE+ZhZEgqkkorNhiPl3FMk
        SblealE4PpHetGWvIgttir3AiTU3Od3at7lXvVXiuHgJepgPVx3FS3QOsB8BAzzxPh+ybmMmm2b4t
        D3c6EeVJ+1EnQi1U/4WkErG7w+aPu/fdUmyyjMHvWaY7BvXthjBcJwbTgoFH5j7cbU+ZwRiF32iT+
        4o65qZ+7Q2bf389OcAEp+UnuCg3Z/gxveArLwWylpzR9qW4lfkNrSQGl87qkjzZv+e9M3DZaUbPes
        bLU5757Q==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1mmlib-0007Uh-3v; Mon, 15 Nov 2021 23:48:57 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id 28AB51A451E4D; Tue, 16 Nov 2021 08:48:54 +0900 (JST)
Date:   Tue, 16 Nov 2021 08:48:54 +0900
From:   Norbert Preining <norbert@preining.info>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [5.12 - 5.15] xHCI controller dead - not renesas but intel
Message-ID: <YZLx5iiKJW1raYFp@bulldog.preining.info>
References: <YY3RIdKBbIL3Dw/q@bulldog.preining.info>
 <8f752efb-e38e-b012-de98-e4b938dde7b7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f752efb-e38e-b012-de98-e4b938dde7b7@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On Tue, 16 Nov 2021, Mathias Nyman wrote:
> Patch in link below resolved another case with similar log. 
> Does it help in your case?

Thanks for the pointer, already installed. I will see whether I get
other failures or it calms down.

Thanks a lot.

Norbert

--
PREINING Norbert                              https://www.preining.info
Fujitsu Research  +  IFMGA Guide  +  TU Wien  +  TeX Live  + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
