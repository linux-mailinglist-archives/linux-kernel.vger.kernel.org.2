Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6241C1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245121AbhI2JqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:46:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36266 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245126AbhI2JqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:46:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 210B9223C5;
        Wed, 29 Sep 2021 09:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632908666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3OPgnctNoGYKNhObA5Ip473mMbcdhlbaElEuG+jg+x8=;
        b=haDumZboDSm0TbhEHMLNJWXKm5jYXO6aTmy+LgMocvps7LMJagJrKtJ83jDeKEOKmccaOd
        Onj7MSffa4iSJC6KAgDdGJc+zZcq+/uxGSHwl0am89J4tB0qCuaYoAc3Vt5ebdO7/d25IV
        Ijd8XbY2RcO4dMCXm/y8Y6papmCcmJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632908666;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3OPgnctNoGYKNhObA5Ip473mMbcdhlbaElEuG+jg+x8=;
        b=E6LTwLj+iu9329OKN80dh5wqOTjxZIKSQCXmgbEZROLWVh43PwnUyHT0LLnotK+52AvEI2
        j9y0pC3o8sKQbEBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EAFA13F09;
        Wed, 29 Sep 2021 09:44:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bMoaA3o1VGE2SQAAMHmgww
        (envelope-from <bp@suse.de>); Wed, 29 Sep 2021 09:44:26 +0000
Date:   Wed, 29 Sep 2021 11:44:17 +0200
From:   Borislav Petkov <bp@suse.de>
To:     =?utf-8?B?6Z+m5Lic6L6J?= <weidonghui@allwinnertech.com>
Cc:     akpm <akpm@linux-foundation.org>, maz <maz@misterjones.org>,
        will <will@kernel.org>, rabin <rabin@rab.in>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?UmXvvJpbUEFUQ0ggdjJdIHNjcmlw?=
 =?utf-8?Q?ts=2Fdecodecode=3A_fi?= =?utf-8?Q?x?= faulting instruction no
 print when opps.file is DOS format
Message-ID: <YVQ1cSttGChXIZ5J@zn.tnic>
References: <17adc8ce-f6b0-4337-a62b-d9a39b000b56.weidonghui@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17adc8ce-f6b0-4337-a62b-d9a39b000b56.weidonghui@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 10:37:07AM +0800, 韦东辉 wrote:
> HI，all Thank you Borislav Petkov for helping me add the CC email
> list. I don't quite understand the meaning of this Google link

（ https://stackoverflow.com/questions/12167178/replace-windows-newlines-in-a-lot-of-files-using-sed-but-it-doesnt）.

> This means that decodecode does not need to process CR(^M)? Must
> ensure that there is no CR(^M) when inputting log? If so, it will
> increase the cost of learning for others. And I think adding tr -d
> "\\015" will not destroy the beauty of the code, but enhance the
> compatibility of decodecode.

You don't need to use a different tool, tr in this case, to remove the
^M character - sed can do that just fine. And that link has the answer
how, I'll let you figure it out.

Also, please do not top-post when replying but put your reply *under*
the text you're replying to, just like I did.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
