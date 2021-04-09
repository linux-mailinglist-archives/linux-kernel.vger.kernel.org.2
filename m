Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96DD35A3E8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhDIQqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234122AbhDIQqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617986759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pdu4RkpS4T4804XEhKz/2H6CTGJICvQ62/yTCfJmHcQ=;
        b=EV5ITLFa9bx4hrAonh3CXKamPxWnOipUHrcsFKmzLSmqABRnG1weMLrdE64sP1nnnmQ/J+
        23cz9V8fmy90bRFsjdMN5U5+xrtenL4viRJDS2kY5HgjLDeiwXB6Jz4U4uUCeFqCku6/Xc
        5ixGHN8m9EujF3jP27IW/kHOsJNC/ww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-PIjy06cYPuG81l9N4Z3jBA-1; Fri, 09 Apr 2021 12:45:57 -0400
X-MC-Unique: PIjy06cYPuG81l9N4Z3jBA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68BEC1B2C988;
        Fri,  9 Apr 2021 16:45:56 +0000 (UTC)
Received: from treble (ovpn-112-2.rdu2.redhat.com [10.10.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1CCA607CB;
        Fri,  9 Apr 2021 16:45:55 +0000 (UTC)
Date:   Fri, 9 Apr 2021 11:45:54 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Saripalli, RK" <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 0/5] Introduce support for PSF mitigation
Message-ID: <20210409164554.w2xtazch5jkivou6@treble>
References: <20210406155004.230790-1-rsaripal@amd.com>
 <20210407223905.5dqgzdaibvgq7jeq@treble>
 <e72bc628-111f-5e3a-bb79-7e77c9fe0424@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e72bc628-111f-5e3a-bb79-7e77c9fe0424@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 09:56:47AM -0500, Saripalli, RK wrote:
> Josh, thank you for taking the time to review the patches.
> 
> On 4/7/2021 5:39 PM, Josh Poimboeuf wrote:
> > On Tue, Apr 06, 2021 at 10:49:59AM -0500, Ramakrishna Saripalli wrote:
> >> Because PSF speculation is limited to the current program context,
> >> the impact of bad PSF speculation is very similar to that of
> >> Speculative Store Bypass (Spectre v4)
> >>
> >> Predictive Store Forwarding controls:
> >> There are two hardware control bits which influence the PSF feature:
> >> - MSR 48h bit 2 – Speculative Store Bypass (SSBD)
> >> - MSR 48h bit 7 – Predictive Store Forwarding Disable (PSFD)
> >>
> >> The PSF feature is disabled if either of these bits are set.  These bits
> >> are controllable on a per-thread basis in an SMT system. By default, both
> >> SSBD and PSFD are 0 meaning that the speculation features are enabled.
> >>
> >> While the SSBD bit disables PSF and speculative store bypass, PSFD only
> >> disables PSF.
> >>
> >> PSFD may be desirable for software which is concerned with the
> >> speculative behavior of PSF but desires a smaller performance impact than
> >> setting SSBD.
> > 
> > Hi Ramakrishna,
> > 
> > Is there a realistic scenario where an application would want to disable
> > PSF, but not disable SSB?
> 
> It is possible most applications have been reviewed and scrubbed for
> SSB-type attacks but PSF-type issues may not have been looked at yet.

It's "possible", but is it realistic?  As far as I know, SSB is
impractical to scrub an application for.

Do we know of any real-world cases where this option is needed?

-- 
Josh

