Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1970405AAD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 18:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbhIIQVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 12:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233878AbhIIQVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631204441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TVfEtg0caKFVLU4PORG/nOTi8TSVXlHDM/vmUHWN4s=;
        b=I0xsEkqSD5VXiuD/EncdJESas/pUkhgEEG0zlTyUQ9ijB3m2BeUFFzccjCPwxmDVbPGEPk
        g8DPCOwcu2S74avlY5bCBj/k6ngVk6bAyUXk0MpKDua1NQj8moQRbSUGFhSd2o0PEIO6yG
        GOSSPkRB/faq4sZnmohVyRlGfHwIvoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-jL2yk899M0yOud7RfMuEnA-1; Thu, 09 Sep 2021 12:20:37 -0400
X-MC-Unique: jL2yk899M0yOud7RfMuEnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 547BC10144F4;
        Thu,  9 Sep 2021 16:20:35 +0000 (UTC)
Received: from epyc.reserve.home (unknown [10.22.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FAFF1865D;
        Thu,  9 Sep 2021 16:20:34 +0000 (UTC)
From:   Bandan Das <bsd@redhat.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
        bp@alien8.de, corbet@lwn.net, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
References: <20210812234440.tcssf2iqs435bgdo@treble>
        <20210902181637.244879-1-babu.moger@amd.com>
        <20210903000706.fb43tzhjanyg64cx@treble>
        <dca004cf-bacc-1a1f-56d6-c06e8bec167a@amd.com>
        <20210904172334.lfjyqi4qfzvbxef7@treble>
Date:   Thu, 09 Sep 2021 12:20:32 -0400
In-Reply-To: <20210904172334.lfjyqi4qfzvbxef7@treble> (Josh Poimboeuf's
        message of "Sat, 4 Sep 2021 10:23:34 -0700")
Message-ID: <jpgo891affz.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf <jpoimboe@redhat.com> writes:

> On Fri, Sep 03, 2021 at 07:52:43PM -0500, Moger, Babu wrote:
>> > BTW, is the list of PSF-affected CPUs the same as the list of
>> > SSB-affected CPUs?  If there might be PSF CPUs which don't have SSB,
>> > then more logic will need to be added to ensure a sensible default.
>> I can't think of a scenario where it is not same on a system.
>
> To clarify, I'm asking about CPU capabilities.  Are there any AMD CPUs
> with the PSF feature, which don't have SSB?
>
>> > On a related note, is there a realistic, non-hypothetical need to have
>> > separate policies and cmdline options for both SSB and PSF?  i.e. is
>> > there a real-world scenario where a user needs to disable PSF while
>> > leaving SSB enabled?
>>=20
>> https://www.amd.com/system/files/documents/security-analysis-predictive-=
store-forwarding.pdf <https://www.amd.com/system/files/documents/security-a=
nalysis-predictive-store-forwarding.pdf>
>> There are some examples in the document. Probably it is too soon to tell=
 if
>> those are real real-world scenarios as this feature is very new.
>
> I didn't see any actual examples.  Are you referring to this sentence?
>
>   "PSFD may be desirable for software which is concerned with the
>    speculative behavior of PSF but desires a smaller performance impact
>    than setting SSBD."
>
Sounds reasonable. It would have been good if the whitepaper mentioned
any real examples which could benefit from selectively disabling psf.
Generally speaking, as a user, I would either want to turn speculation
entirely off or on which is what ssbd already does.

>> > Because trying to give them separate interfaces, when PSF disable is
>> > intertwined with SSB disable in hardware, is awkward and confusing.  A=
nd
>> > the idea of adding another double-negative interface (disable=3Doff!),
>> > just because a vulnerability is considered to be a CPU "feature", isn't
>> > very appetizing.
>> >=20
>> > So instead of adding a new double-negative interface, which only *half*
>> > works due to the ssb_disable dependency, and which is guaranteed to
>> > further confuse users, and which not even be used in the real world
>> > except possibly by confused users...
>> >=20
>> > I'm wondering if we can just start out with the simplest possible
>> > approach: don't change any code and instead just document the fact that
>> > "spec_store_bypass_disable=3D" also affects PSF.
>> >=20
>> > Then, later on, if a real-world need is demonstrated, actual code could
>> > be added to support disabling PSF independently (but of course it would
>> > never be fully independent since PSF disable is forced by SSB disable).
>>=20
>> Do you mean for now keep only 'on' and=C2=A0 'auto' and remove "off"?
>
> No, since PSF can already be mitigated with SSBD today, I'm suggesting
> that all code be removed from the patch and instead just update the
> documentation.

