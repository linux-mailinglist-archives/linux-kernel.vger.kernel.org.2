Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5014F3A5DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 09:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhFNHeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 03:34:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36644 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232424AbhFNHeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 03:34:31 -0400
Received: from zn.tnic (p200300ec2f09b9009f623ab99c6783e2.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b900:9f62:3ab9:9c67:83e2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 624B41EC0242;
        Mon, 14 Jun 2021 09:32:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623655947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1EYxAH3LhswslDYKCk/cMLyhmfL3MWWHQqXTdVucXDs=;
        b=UX89MrjPChqMquHFrf+t3U1o2eaRW9LcttpriSqi4lpsSExdMJlQX05RjizxODCCVjMHQV
        Z0tkZ/MSI1dZYWKsAYEJum0JhGEtEdxuxqLXYj8S6VvmkL6eK5IC3gBAyiP78qcNzVpN0c
        wEGQVDQ6xI5pqd0dXOEXsaY08DcASms=
Date:   Mon, 14 Jun 2021 09:32:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Hubert Jasudowicz <hubert.jasudowicz@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: Remove references to IBM Calgary
Message-ID: <YMcGAnwU1Amoga88@zn.tnic>
References: <1bd2b57dd1db53df09e520b8170ff61418805de4.1623274832.git.hubert.jasudowicz@gmail.com>
 <87h7i1bc0i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h7i1bc0i.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 05:06:21PM -0600, Jonathan Corbet wrote:
> Applied, thanks.

I took it already:

https://git.kernel.org/tip/0e5a89dbb49920cea22193044bbbfd76a9b0f458

You can drop yours. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
