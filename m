Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861583D8C72
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 13:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbhG1LFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 07:05:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55644 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhG1LFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:05:39 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7418D1FF88;
        Wed, 28 Jul 2021 11:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627470337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOykOnev2OKwH7zGa/ujn988oGAsj2Lxft3mdvsvMWQ=;
        b=HuBe5Qo8P4HXSbjareNeEzbDKXvbOzaYboIh5oYS/TJSdGtu2k0EZCPUJST60cdijhaaJr
        sXqm6GvTJp0GhP+AVg/hAmhrL713g1m29P/uzifVP8OrEBj66IXEXjUTK6/MyR+VACd5u/
        y3f5/7Wg/fyblrCRTQ9edk+xAjBvu8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627470337;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOykOnev2OKwH7zGa/ujn988oGAsj2Lxft3mdvsvMWQ=;
        b=GBdU0qvyiVseGe1r6+CESQSsoVxU2o7lrlAvWkeNSRy+oKybiVlIPdjB/4hI92mJSGAoPM
        sZqr102ODFCgSUAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 373E513983;
        Wed, 28 Jul 2021 11:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id /dQqCwE6AWF3NAAAGKfGzw
        (envelope-from <jroedel@suse.de>); Wed, 28 Jul 2021 11:05:37 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [BUG] crypto: ccp: random crashes after kexec on AMD with PSP
 since commit 97f9ac3d
From:   =?utf-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>
In-Reply-To: <YQB3B1RMhPqcrqzW@xanadu.blop.info>
Date:   Wed, 28 Jul 2021 13:05:36 +0200
Cc:     linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Gary Hook <gary.hook@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2C0BD57-3DC3-436F-98F3-44D85F9DEBC4@suse.de>
References: <YQB3B1RMhPqcrqzW@xanadu.blop.info>
To:     Lucas Nussbaum <lucas.nussbaum@inria.fr>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 27.07.2021 um 23:13 schrieb Lucas Nussbaum =
<lucas.nussbaum@inria.fr>:
>=20
> It is worth noting that there was prior work about getting kexec to
> work with PSP/SEV (commit f8903b3e, "crypto: ccp - fix the SEV probe =
in
> kexec boot path=E2=80=9C).

This patch adds the TMR memory for the PSP. I guess a reboot-notifier is =
needed which shuts the PSP down and flushes all caches.

Regards,

J=C3=B6rg=
