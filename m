Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3173C3B0F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 23:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFVVJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 17:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229629AbhFVVJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 17:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624396011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iwNIivw7ND0ogSAYON5f+dYUQ2aKcYsMFanvNB5fm5o=;
        b=Eeyt/0+V0MRy6gYLpGQhaj2fhd0rWVoC6ZjUfclv/h7HTtoM2YgAEov/0aUa3MuOZPpxZi
        Hw4GivzNdXDM3OI48Sx7PTwyI5tJenXfl+d6l6fBZcJWBRcUjyncjg+TyhDpQ/0r0E9eNs
        qZ/YIRfXhqit2LluqQh/48FHe5ozRGg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-wXpDWBDpNautU9PxYd1gWg-1; Tue, 22 Jun 2021 17:06:50 -0400
X-MC-Unique: wXpDWBDpNautU9PxYd1gWg-1
Received: by mail-wr1-f70.google.com with SMTP id v9-20020a5d4a490000b029011a86baa40cso67790wrs.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 14:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iwNIivw7ND0ogSAYON5f+dYUQ2aKcYsMFanvNB5fm5o=;
        b=Xl+Kjd5vYO8M3BCTwQU+/xlssuqZl0cMJL/Ip6mShq0a9t22bCnYboKPklqrlRRFFx
         wIFUcwXKMq+sNzuHmw/TVLUkckMZj+IVx8dTnXcokI7defPKFEDusc+X0KqynxkIBFex
         M+ygRO09Cw3r2YuejgqQp/cfHTCAlQ6cIoxEkz8Y9B8+D8WvyXi3fUCogaXmxr7jtiGU
         JksH9Y+I7DS629AKgoGYRE5tzXr14mOwQj7WlSmfQVs/AEXBVtGVD3VHbHNHqTEH80cD
         1KqxOlbJWfDm543L9HPzuNFjyx7JnhA4UimPfM55oxl5iDfQlxBpYBLPgrurCK+2lik7
         enIw==
X-Gm-Message-State: AOAM533eb/AfJf4zNLOdEtTfoHBWPut9+nW0G5JSf6Miq0j1heLGoMi9
        yaDh9aotIEbSmQhz3oLlkahckyU4mOj4N9YjtjTMIHvo/xGOn/jVctYdJ1l71wWUQHPDEyNNF6z
        NONQ7hUQbWU/92Qbd2JdQUBdr
X-Received: by 2002:a1c:2601:: with SMTP id m1mr6867474wmm.185.1624396009165;
        Tue, 22 Jun 2021 14:06:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwA5evujCVmb41YGb1m83sZnYPN7g9tyPdWnf8NtEzUikjTHKJvyfO0OIMVr5bOTFLyikgVQ==
X-Received: by 2002:a1c:2601:: with SMTP id m1mr6867441wmm.185.1624396008898;
        Tue, 22 Jun 2021 14:06:48 -0700 (PDT)
Received: from krava ([5.171.245.189])
        by smtp.gmail.com with ESMTPSA id e11sm504551wrs.64.2021.06.22.14.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 14:06:47 -0700 (PDT)
Date:   Tue, 22 Jun 2021 23:06:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: libperf : Can not create event group
Message-ID: <YNJQ5P3jgOcL7sMD@krava>
References: <OSBPR01MB46005B38568E90509946ECA9F7319@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YMc6tBoIQiUQkRbq@krava>
 <OSBPR01MB4600B6FCE4D95F6B84E7E17CF7099@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4600B6FCE4D95F6B84E7E17CF7099@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 07:57:56AM +0000, nakamura.shun@fujitsu.com wrote:
> Hi, jirka
> 
> > there'no leader link on this level yet (in struct evsel)
> > so this is not implemented at the moment
> 
> Thanks for the info.
> 
> Do you have any plans to support the event group in libperf?

hi,
not until now I guess ;-) what's your use case?

jirka

