Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AB541F411
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355559AbhJAR7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:59:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58920 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355546AbhJAR7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:59:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 558581FEFD;
        Fri,  1 Oct 2021 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633111073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ilpkw1PaV61JJ9sLSth/ZoVtlT/iBzt2bJzF/XtJ8pE=;
        b=OLYLYoWltMBBM6EdoElvxv4XEK2Q+Cy6HrHDb34cmiCsqY1v//d2cW4ICkObOpj7zYTm54
        C0XFZv0M+qpjLwJx351JKfZQl7UuvkowO9wsN7Bgjbg6VaRBrtx1Hczan6G4T/H5Qj7fVm
        2Vd2rkCsQhbQ0uPv//zas71+VAPR9Gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633111073;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ilpkw1PaV61JJ9sLSth/ZoVtlT/iBzt2bJzF/XtJ8pE=;
        b=xIpct/XFDEefOkbidhPMwyPTaiasloJk9SxrUdEoNWKqaG/F5WXhihC5vpl4Fyp0dpIddF
        3I6ALLafMEtYPzCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D50FD13BC3;
        Fri,  1 Oct 2021 17:57:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EMRkMiBMV2H+DQAAMHmgww
        (envelope-from <jroedel@suse.de>); Fri, 01 Oct 2021 17:57:52 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v3 3/4] x86/mm: Flush global TLB when switching to
 trampoline page-table
From:   =?utf-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>
In-Reply-To: <03994224-abba-4551-9f9d-1360af69c78e@intel.com>
Date:   Fri, 1 Oct 2021 19:57:52 +0200
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <76A7441A-2A7B-4FBD-A17E-B370893B9CEA@suse.de>
References: <20211001154817.29225-1-joro@8bytes.org>
 <20211001154817.29225-4-joro@8bytes.org>
 <03994224-abba-4551-9f9d-1360af69c78e@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 01.10.2021 um 18:13 schrieb Dave Hansen <dave.hansen@intel.com>:
>=20
> On 10/1/21 8:48 AM, Joerg Roedel wrote:
>> Move the switching code into a function so that it can be re-used and
>> add a global TLB flush. This makes sure that usage of memory which is
>> not mapped in the trampoline page-table is reliably caught.
>=20
> This looks fine.  But, just to be clear, nothing in this series reuses
> the code, right?

Correct, but my SEV-ES kexec series will re-use it, as it also uses the =
trampoline_pgd and switches to real-mode to park the APs.

Regards,

J=C3=B6rg=
