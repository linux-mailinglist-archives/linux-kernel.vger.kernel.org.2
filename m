Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5D45CBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350409AbhKXSVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:21:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242520AbhKXSVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637777899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aImuXRsg8yxI6g3AKa1ZMJeiF400ljnzLc9mnInKQqk=;
        b=UneTVI16XDCBvzZbylUqtwzDYMe4t09w3sNSsx7pjidRmxYXgpyS0xiDSH5Poo+knos9qR
        hnItwPBSLBn+sd72aLPta2HIbTdJoRAUbbebOqEenhgde8LofX8evO9BweH/1IiO6Id04u
        iXOxT4mr/3nbYEfCEDlQM8Ht9lDA9gc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-506-7D3gM_edP6SGhWgScnEjew-1; Wed, 24 Nov 2021 13:18:18 -0500
X-MC-Unique: 7D3gM_edP6SGhWgScnEjew-1
Received: by mail-ot1-f72.google.com with SMTP id a9-20020a056830008900b0056561b8c755so2043849oto.22
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aImuXRsg8yxI6g3AKa1ZMJeiF400ljnzLc9mnInKQqk=;
        b=gxUGkkwP0lYhx9Mw6vIonbSlcYwpWQJ6QRWe2hux94D+yFlaoW91rFf7Mh4WKRaB22
         WUa5Q/F5SH7t9UraKNg2mwkSoP2arWSMQgHVtgznsF0cUxtcMGKHieQ0R/WWvweV/6fZ
         nWUr/iv1ZNVCarIVZurPMjmPqraM56zm2kZ5sR3GNvk20I0JGs2SGOWGaS3IrUS/DKWz
         8MLF4KbUtdwLDnJVK4V+DsVuTP5TqIDC5ywISwc5WR1dNL5LxJuEja96aaunUB0Znffl
         W1dVD8ilTiQsfbG4kuN9ALu1Pl9SJuX3roXflIhGTx2j7EBxphI0aFhGzoTnh69Pc129
         HtoA==
X-Gm-Message-State: AOAM531NYSVJiSAHHF9a8wCyrxIhzNDzp584Hr869s77HRgXgwMw0XFk
        h3I3DF/jGnbtGqEjT5PMiyeWVD5HGfizs2va4vnyioMgllOD/c9nSKXeeSWUyxViY3/xo2q4nzR
        rE9q36zcmGga9g0fOm+++4ae/
X-Received: by 2002:a05:6808:230d:: with SMTP id bn13mr8587363oib.102.1637777897692;
        Wed, 24 Nov 2021 10:18:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzv7e8nF+f1PWTCzu4bP/3XrRnuLWwR+3nOYDyykdCd/W64HSkTJm6pIPem5/EDCm6JYQ3Mlg==
X-Received: by 2002:a05:6808:230d:: with SMTP id bn13mr8587323oib.102.1637777897463;
        Wed, 24 Nov 2021 10:18:17 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id bh12sm133130oib.25.2021.11.24.10.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 10:18:16 -0800 (PST)
Date:   Wed, 24 Nov 2021 10:18:14 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com
Subject: Re: [RFC][PATCH 1/6] x86: Annotate _THIS_IP_
Message-ID: <20211124181814.2ahj7ppt6kewcjmb@treble>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.025419814@infradead.org>
 <20211123135348.GE37253@lakrids.cambridge.arm.com>
 <YZz3VUh2czlD1aWQ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZz3VUh2czlD1aWQ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 03:14:45PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 23, 2021 at 01:53:49PM +0000, Mark Rutland wrote:
> > On Mon, Nov 22, 2021 at 06:03:02PM +0100, Peter Zijlstra wrote:
> > > In order to find _THIS_IP_ code references in objtool, annotate them.
> > 
> > Just to check my understanding, IIUC this is because in later patches
> > you'll look at text relocations to spot missing ENDBRs, and when doing
> > so you need to filter out _THIS_IP_ instances, since those don't need an
> > ENDBR. Is that right?
> > 
> > Just checking I haven't missed some other concern that might apply to
> > arm64's BTI (Branch Target Identifier), which are analagous to ENDBR.
> 
> Correct; since _THIS_IP_ is never used for control flow (afaik, let's
> hope to $deity etc..) we can ignore any relocation resulting from it
> (lots!).

This would all be good context to add to the commit message.

-- 
Josh

