Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6072E32ADD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838075AbhCBWPQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Mar 2021 17:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377782AbhCBT4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:56:19 -0500
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FD6C061794
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 08:51:53 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 770CBC800D3;
        Tue,  2 Mar 2021 17:51:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id KBrrrSGKOnzX; Tue,  2 Mar 2021 17:51:52 +0100 (CET)
Received: from [IPv6:2003:e3:7f23:4700:cc41:88a7:f2f8:d6b8] (p200300E37f234700CC4188A7f2f8d6b8.dip0.t-ipconnect.de [IPv6:2003:e3:7f23:4700:cc41:88a7:f2f8:d6b8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 3F11DC80094;
        Tue,  2 Mar 2021 17:51:52 +0100 (CET)
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Clevo NH55RZQ
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <c7a394b1-edd3-a692-0981-45086da82aac@tuxedocomputers.com>
 <s5hsg5dfy4h.wl-tiwai@suse.de>
From:   Werner Sembach <wse@tuxedocomputers.com>
Autocrypt: addr=wse@tuxedocomputers.com; keydata=
 mDMEX6ALvhYJKwYBBAHaRw8BAQdAG/kE3mlbV1YLpCU8iA7Pyq2eDq9LxzGQxcOZODh2Vnq0
 KFdlcm5lciBTZW1iYWNoIDx3c2VAdHV4ZWRvY29tcHV0ZXJzLmNvbT6IlgQTFggAPhYhBNzq
 jJqAsvWKK1h7bi7eQpXUvijKBQJfoAu+AhsDBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMBAh4B
 AheAAAoJEC7eQpXUvijKzkEA/jblmQRWU/e18oo8J9GPHWOCRUA1WJLUt9lSye5cgl2vAP0Y
 q+EpkDRS+QqtIcIr3fVELwA4b/V1lVE2LW+plcmdCbg4BF+gC74SCisGAQQBl1UBBQEBB0Bc
 k3J9DVAB4ysrdDcKE7L9iAUjlWD+rsLh/5soPORqFQMBCAeIfgQYFggAJhYhBNzqjJqAsvWK
 K1h7bi7eQpXUvijKBQJfoAu+AhsMBQkJZgGAAAoJEC7eQpXUvijKBBYA/2DT2g26dpTU2Rbc
 lqviltu+woGZCd0GBfRgXuzUK0OfAQCwr8qPCl8uIsBgOsDmWIJYByG2ddwmXiAgBS1985bM Ag==
Message-ID: <25fe7622-75e4-ec57-84e3-a41560bb8dee@tuxedocomputers.com>
Date:   Tue, 2 Mar 2021 17:51:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <s5hsg5dfy4h.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Takashi,
> The patch isn't cleanly applicable.  Could you try to submit via
> git-send-email instead?

I'm sorry the editor + mailer i used replaced tabs with spaces and made a html mail.

Already resend the patch with tabs, but only after that I realized that even the "plain" mails are converted to html.

It's probably still broken so don't waste your time with it, i will read the man page of git send-mail now ^^.

> Cc to stable is worthwhile.  You can simply add
>   Cc: <stable@vger.kernel.org>
>
> around your signed-off-by lines in the patch.

Ok (also forgot that in my resend patch)

Kind regards,

Werner Sembach


