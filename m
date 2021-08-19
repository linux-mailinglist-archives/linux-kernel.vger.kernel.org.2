Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6CF3F1AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbhHSNuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:50:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60238 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbhHSNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:50:07 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE67921BB8;
        Thu, 19 Aug 2021 13:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629380970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UDIiiE/MsKGPsprG0zYleOsVRfDkfX7JM2upp2Bj19I=;
        b=MdAATiPKAM86ZRT61nj2j6hra4zEwFE3mRLZmEmI4qqhyU0SYJB2XwRJZPunawXr08O0UJ
        1d84e7vYBelQMhilcNduOUdBLCl8Fk/YBkgUKfCP0YW046/yNXRxeeFrXz73ynpVkDYGPg
        ooWG8n6HoPzRVNtXFu4zgue8vuxf2lE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629380970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UDIiiE/MsKGPsprG0zYleOsVRfDkfX7JM2upp2Bj19I=;
        b=GZc5Bud0ygEDs1gdwtE2Ig3HBJ0Hz1SFt4auYjPi2NZOp+jv9AaHVt9WzPlW+nxr5GrRld
        auOdv+DJeCKP79BA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 778A81363C;
        Thu, 19 Aug 2021 13:49:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 5NKEGmphHmFNfgAAGKfGzw
        (envelope-from <jroedel@suse.de>); Thu, 19 Aug 2021 13:49:30 +0000
Date:   Thu, 19 Aug 2021 15:49:28 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: x86/boot/compressed/64: Lenovo Ideapad Miix300 bug report
Message-ID: <YR5haH+K4fjm/cnK@suse.de>
References: <20210819100230.GA28768@agape.jhs>
 <YR4uffjFuqvrz1Tp@zn.tnic>
 <20210819121653.GB28768@agape.jhs>
 <YR5dtDvvcgekoIJu@suse.de>
 <20210819134328.GD28768@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819134328.GD28768@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 03:43:28PM +0200, Fabio Aiuto wrote:
> shall I restore back CONFIG_AMD_MEM_ENCRYPT?

Yes, please restore it.

Thanks,

	Joerg
