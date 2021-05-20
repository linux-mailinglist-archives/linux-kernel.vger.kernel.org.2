Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568AF38A061
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhETI64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231414AbhETI6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621501046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWnNUjDPqTQnCEdVQgn9AK9G/tH/6V7Bqn/kJuiQYN0=;
        b=h/rjzvQyLwR+4NnsFaWLxMdzReWa7gT+aBYPiEbB7IsQXFvNWFzWejMkVXqNm4edZGcBiJ
        2wnDqzaqgjytcALphHW7ziOzGKsCFMfNHFrj1bo49YV2aHvHSPDUci1erFexydNb/ej3mJ
        LSc4YT++zbkrynH9ktZXt+E+3RNCJrY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-jijzeIKQNSyl2GuZeF0Ntw-1; Thu, 20 May 2021 04:57:23 -0400
X-MC-Unique: jijzeIKQNSyl2GuZeF0Ntw-1
Received: by mail-wm1-f70.google.com with SMTP id z1-20020a1c7e010000b0290179806d11d4so980193wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 01:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QWnNUjDPqTQnCEdVQgn9AK9G/tH/6V7Bqn/kJuiQYN0=;
        b=jGJy4DXKq4ZWtBzEKmr2ssEoZHfuktBddv8jBptVUMtstvcfgAIA0l/Vs0QTpwT8w0
         RoVy4OeiIHr6UVRkQ0BmlK840vwbsCknGKGv8DhDeLkLRyCQlnRUytQgpMMgiOuG1EZo
         mJDZtw+K5T0A2k555khIpcvcmyr+LTguqVq91hj4ABgVMJgrNZAiu03dbvTM8/G7piU6
         4SU65srVHJM+AOxJjiPSoCgb/3r7CBmXKh+If+Jye/5AkXkJbimwdz3838tvmyOI/nFw
         qxDuL7TXgnSZHZJHMEbGy6APMQmDK71gPnA4/YZNUIt1G6NMUWzX1n7V/22ZGkgfxG32
         IdgQ==
X-Gm-Message-State: AOAM532RrxCjD/8wpPy8XyX/jGx7vr7GiWeSD/ffXycSbooFMpOfE/XO
        AEnScxcjpQln9qDWQZPLP8XjI+EUqsqcRCH4u5jMT4zVffxO+YmRM+gNnLY36igoNnJVqdo/70n
        PdIh/tZcsTZ9V8JU65QUN+iz6
X-Received: by 2002:a5d:4408:: with SMTP id z8mr3215108wrq.2.1621501042373;
        Thu, 20 May 2021 01:57:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7C586/nRMw6N6pfpuwHqH+Jr2J4jLlf2ul5cHMgRk7/v6t932rZ4dOBYUsQc/VFZ/uvp2cg==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr3215095wrq.2.1621501042243;
        Thu, 20 May 2021 01:57:22 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1c02:2700:ca67:ddac:104e:9b35? ([2a0c:5a80:1c02:2700:ca67:ddac:104e:9b35])
        by smtp.gmail.com with ESMTPSA id i1sm2375070wrp.51.2021.05.20.01.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 01:57:21 -0700 (PDT)
Message-ID: <e2e9c8e80b64bb3612f780e2351621070ace25f8.camel@redhat.com>
Subject: Re: [RFC] trace: Add option for polling ring buffers
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     rostedt@goodmis.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, corbet@lwn.net,
        mtosatti@redhat.com
Date:   Thu, 20 May 2021 10:57:21 +0200
In-Reply-To: <YKVT+sQTgNpCR/Gt@casper.infradead.org>
References: <20210519175755.670876-1-nsaenzju@redhat.com>
         <YKVT+sQTgNpCR/Gt@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew, thanks for your comments.

On Wed, 2021-05-19 at 19:07 +0100, Matthew Wilcox wrote:
> On Wed, May 19, 2021 at 07:57:55PM +0200, Nicolas Saenz Julienne wrote:
> > To minimize trace's effect on isolated CPUs. That is, CPUs were only a
> > handful or a single, process are allowed to run. Introduce a new trace
> > option: 'poll-rb'.
> 
> maybe this should take a parameter in ms (us?) saying how frequently
> to poll?  it seems like a reasonable assumption that somebody running in
> this kind of RT environment would be able to judge how often their
> monitoring task needs to collect data.

I'll look into it.

> > [1] The IPI, in this case, an irq_work, is needed since trace might run
> > in NMI context. Which is not suitable for wake-ups.
> 
> could we also consider a try-wakeup which would not succeed if in NMI
> context?

Yes, in a similar vein, my original idea was to defer the wakeup process into a
non-isolated CPU using irq_work_on(). But that irq_work flavor is not NMI safe
(nor any other IPI mechanisms targeting other CPUs).

> or are there situations where we only gather data in NMI
> context, and so would never succeed in waking up?

Yes, that's a use-case. For ex. 'trace-cmd record -e nmi'.

> if so, maybe schedule the irq_work every 1000 failures to wake up.

You'd be generating latency spikes nonetheless. Which might eventually break
the isolated application latency requirements.

As Marcelo said, the least code we run on the isolated CPU the better.

-- 
Nicolás Sáenz

