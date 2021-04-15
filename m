Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006EB360BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhDOOeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230056AbhDOOeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618497220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DN2UJaEtENrsdEqdKuTrcReV84BAkt22oNwtGa+zUKY=;
        b=ewXaUUGKzOOJjNcr5JP3r+pFk6ySY5WQ+U9mPW3SmBQdGhsn1l5i/VsXSTVZlV/iA8CpIg
        EprJ5QpyZ8VFCsDQvTLubk81ZMCT5P6esEEXIIm5m3KaTF8BzuhK7tDPu01Gd48eRvmE+3
        KpKsnMAegHUv7Tbh2T5SUZIymxg4bq0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-b8xrXFaROjGS2T6PK7sAww-1; Thu, 15 Apr 2021 10:33:38 -0400
X-MC-Unique: b8xrXFaROjGS2T6PK7sAww-1
Received: by mail-ed1-f70.google.com with SMTP id v5-20020a0564023485b029037ff13253bcso5294531edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DN2UJaEtENrsdEqdKuTrcReV84BAkt22oNwtGa+zUKY=;
        b=ASg+GZ79mhVp+cjO7/5OQ/flj8DjrPnOK5IJodRPbsbCNaOhGfN6DZz+r4oyz6srQR
         bb0bKLc4tuvjbpmvxC+4W5yezk8KN3RDqhqzwpkCzQj0oEp7im04d48fx8CQgp34ju3b
         e8SmsYuM4Dr0YP/dOGAg/Ln4Q+QMaHBr9NLvJpD9PJbxHbmlXr2ea9q+6mycIxxDxaGZ
         PalKrdcAFnfLuWOUguVc0NkrheSROgO1B9q7bIxzYDjkOaTfAo3Uj06LbxXahgI0y7M9
         2OM5EHsXG/UsPfXRA/Y936VuDd0h9psouy+zp+p3rARdd4KZ2DFhG3WVtjs3sC/jwIdA
         weyw==
X-Gm-Message-State: AOAM532edAEzy9ZkHJSOa0glbhF5DsySx6IvoJvctIq0eC+0GP4ZIAhb
        OPz9Gg0BjdSGuCMyFbQ8O/vajwekZXL1VcH7tw2JR6bGpA0S+jE2AQdgr8DUT7fwB1gB6cF5ztJ
        j6ajZaIyrdq+X3EoIevwtC6US
X-Received: by 2002:a17:906:5619:: with SMTP id f25mr3619627ejq.393.1618497217730;
        Thu, 15 Apr 2021 07:33:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp2+FhsiYsOxodUrmeark8TAuibstvh2k+JmEcDe8RIeCMxv7wz3iV2fdraEt9h+jfKBLYWg==
X-Received: by 2002:a17:906:5619:: with SMTP id f25mr3619603ejq.393.1618497217610;
        Thu, 15 Apr 2021 07:33:37 -0700 (PDT)
Received: from x1.bristot.me (host-79-56-201-31.retail.telecomitalia.it. [79.56.201.31])
        by smtp.gmail.com with ESMTPSA id c7sm2615614edt.84.2021.04.15.07.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 07:33:37 -0700 (PDT)
Subject: Re: [RFC PATCH 1/5] tracing/hwlat: Add a cpus file specific for
 hwlat_detector
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, kcarcia@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
References: <cover.1617889883.git.bristot@redhat.com>
 <94bbcd0e0f06b79aeb775e8dbf3a301f6679bb4c.1617889883.git.bristot@redhat.com>
 <20210414101019.7c5a66f6@gandalf.local.home>
 <e5547e9a-d3d8-2cd1-7cb9-e567c798e78d@redhat.com>
 <20210415094924.473a98df@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <a07b6ec2-8bfb-8d72-6380-34654921702e@redhat.com>
Date:   Thu, 15 Apr 2021 16:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210415094924.473a98df@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 3:49 PM, Steven Rostedt wrote:
> OK, for osnoise, I can see how it is useful. But as you said above, for
> hwlat tracer, it's not as useful.

I agree, it is not as useful.

-- Daniel

