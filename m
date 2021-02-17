Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E48B31DA89
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 14:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhBQNbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 08:31:36 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:34891 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhBQNZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 08:25:02 -0500
Received: by mail-pj1-f51.google.com with SMTP id e9so1634253pjj.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 05:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u2cJMjjiPBbtvBqVcbWhNJ2KbEiNTDRP7BhgNFtCWy8=;
        b=R8KCt0x7PzZHiywehxzlfGWLkOL40Exvc3iW0Z0hRlwNsAurd9sDsQGcMrUvjB/220
         V71RGUBHh8nOA13gaIIXU2eOWcE7OobRxhpJtWAyoFtmynRmYN4+LZEnqlr1nHPDPRyB
         AKc1xFlfQ7GKPSx30VkVwLdFYvqneEl5R3bKMQKswMzHUUIeoTES6z5duvFowiNDLyTf
         8ZYl7Fn/bdNOS0GNx7HhtTU/LvGTBdDxwL3htTYyoMKBJZit2ELIr4KQgMPp6sf92iWw
         KVNrvAYbPN4U3vOotf04Fc9gP7XMkdq16hZmWj9snQHbRPaJ0+FgsLB48puc4LMmPlsG
         Yyww==
X-Gm-Message-State: AOAM531RAQhEac3DPIHm9JEKH7kjslcy9B7N1c0/uihLL5nhcvTKIckD
        Dh1tYY4dzd+PnGAvKopJj/U=
X-Google-Smtp-Source: ABdhPJxtJXK0mMsxK0k1Y/7OmnI1cFl3Kqvg21fmR+HRrR0B/HSCARcXuCxzv1JX5nVSvZFtlGVniQ==
X-Received: by 2002:a17:90a:3905:: with SMTP id y5mr8896275pjb.203.1613568261069;
        Wed, 17 Feb 2021 05:24:21 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g6sm2628542pfi.15.2021.02.17.05.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 05:24:20 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4523940277; Wed, 17 Feb 2021 13:24:19 +0000 (UTC)
Date:   Wed, 17 Feb 2021 13:24:19 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] firmware: Add the support for ZSTD-compressed
 firmware files
Message-ID: <20210217132419.GN4332@42.do-not-panic.com>
References: <20210127154939.13288-1-tiwai@suse.de>
 <20210127154939.13288-2-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127154939.13288-2-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 04:49:36PM +0100, Takashi Iwai wrote:
> Due to the popular demands on ZSTD, here is a patch to add a support
> of ZSTD-compressed firmware files via the direct firmware loader.
> It's just like XZ-compressed file support, providing a decompressor
> with ZSTD.  Since ZSTD API can give the decompression size beforehand,
> the code is even simpler than XZ.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

It also occurs to me that having a simple like #define HAVE_FIRMWARE_COMPRESS_ZSTD
on include/linux/firmware.h would enable userspace to be aware (if they
have kernel sources) to determine if the kernels supports this format.

  Luis
