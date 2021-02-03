Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1760630DD20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhBCOnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:43:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232583AbhBCOnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612363343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GZ6qRidFOSYkf7GW77fuOiKw7jeD4KSibc9szHIC5ls=;
        b=UMPIUpS4WdwT/N+ABQKYp/AeONEDBVVAoRI7xC+FMhnZbiuCATppRhXSlhlT27YZmZ9O1p
        /eN/mbqUmg7Tl44ATt9Lmv+Bg/i/w9l5RyS5kOxWHoHFc0wVQ8C89rresi1SDpM0qCoO0r
        oBPY5M2qx1bpaZ+10hI45IIzRwsUYoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-sJlsEx60NY-UMm0Vr1cc4Q-1; Wed, 03 Feb 2021 09:42:19 -0500
X-MC-Unique: sJlsEx60NY-UMm0Vr1cc4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A0FDAFA81;
        Wed,  3 Feb 2021 14:42:18 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CE5360C6C;
        Wed,  3 Feb 2021 14:42:17 +0000 (UTC)
Date:   Wed, 3 Feb 2021 08:42:15 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] objtool: Change REG_SP_INDIRECT
Message-ID: <20210203144215.4ledy6srx7zwfxde@treble>
References: <20210203120222.451068583@infradead.org>
 <20210203120401.062155900@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210203120401.062155900@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 01:02:23PM +0100, Peter Zijlstra wrote:
> Currently REG_SP_INDIRECT is unused but means (%rsp + offset),
> change it to mean (%rsp) + offset.
> 
> This is somewhat unfortunate, since REG_BP_INDIRECT is used (by DRAP)
> and thus needs to retain the current (%rbp + offset).

Offset is going to be zero, should it not work either way?

-- 
Josh

