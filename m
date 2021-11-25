Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD0045DA7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354691AbhKYM6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354835AbhKYMz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:55:59 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46076C0613FA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 04:49:15 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so5703445pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 04:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=k/MWypq4OBux59HLtphgq3y+jYzXV/Eny8GlcFdLOas=;
        b=DM++8XjiAdNVOKnR235uLPsu3V7ioJ1QiaC+hn444jiViWTXc5yAgQpulIzPk+NrLY
         XQCYP8RzntxdEvPGGN0EyiQS2OG7eT3j2VMMl8h4oGn36hpBuC6gVWAdynRpBvDmu/Wk
         4RVrZo8uPamvn/VD8zk+pCcSoMePR/WGfJRRKrvfuuOldwOICc4mcFU/+xcbfhu30ywk
         DgRE4eZpWmCQXBAapS3uzd7ZyRpl0ymXw7qoFLjBWfxZXmWh6kH5JACONhYCVsKN/jiK
         PsfKsxpCgVoTgVjJBwb6JpBKlSC67YrF3VUsVcQEKllSXN8XCeoXpFT9Lh6KCXHfHIMS
         2N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k/MWypq4OBux59HLtphgq3y+jYzXV/Eny8GlcFdLOas=;
        b=6kVKuxO7Uiv2HCdlcr3iOnIzNPekZgByJlqx/RuUOa3xRr7M1trYe0OTgpsc0h9VqB
         a3t/Th4ugB8AF9U/9kHyG73QivR0DppI1dOWHetWUk9y8w9mnsq6rT5iN6qJeKaR6pTt
         G4rAvAyc5Ja08Nnt3y+tU8o4zWLs7szrCHEji+c6cXWzbTbHrHWbREKBceKgLveSrs3C
         ks7fRISxL4L9bTET+Dap/U7HKmaSwzlDR1p9oDTJSq+uqC3B1G9TTPHa/m1T/BmUJyiE
         /VKc4D6c/w9uajfUySvjG2HLDrmqdHkZS+aA/keDOdCaJukIx7JKly+GglIYimhEo+IP
         7hWw==
X-Gm-Message-State: AOAM533av2+9lUXA0hnEhbVQ+FtfmTJdfxlelaS3klqYLID+O7MyRequ
        2FTD4bIx2WzaLEF/bZ8nAK13OQ==
X-Google-Smtp-Source: ABdhPJx2nsF+0S1dK+zNLc3mYLq8EgRxjoK6/V/RrnxgrXSeC55p+L34mPLMjCVch6FJ3HVwSObS+w==
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr6767330pjb.43.1637844554786;
        Thu, 25 Nov 2021 04:49:14 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([66.23.193.248])
        by smtp.gmail.com with ESMTPSA id t19sm2436110pgn.7.2021.11.25.04.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 04:49:14 -0800 (PST)
Date:   Thu, 25 Nov 2021 20:49:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH 1/1] perf arm-spe: report all SPE records as "all"
 events
Message-ID: <20211125124905.GC1599216@leoy-ThinkPad-X240s>
References: <20211117142833.226629-1-german.gomez@arm.com>
 <20211125075358.GA1599216@leoy-ThinkPad-X240s>
 <3a84dd85-7bae-49ea-75cc-52f9a8220cc4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a84dd85-7bae-49ea-75cc-52f9a8220cc4@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 11:54:16AM +0000, German Gomez wrote:
> Hi Leo,
> 
> On 25/11/2021 07:53, Leo Yan wrote:
> > On Wed, Nov 17, 2021 at 02:28:32PM +0000, German Gomez wrote:
> >> [...]
> > After checked the event types, I think "other" samples would include
> > below raw event types:
> >
> >   EV_EXCEPTION_GEN
> >   EV_RETIRED
> >   EV_NOT_TAKEN
> >   EV_ALIGNMENT
> >   EV_PARTIAL_PREDICATE
> >   EV_EMPTY_PREDICATE
> >
> > I am just wander if we can use sample.transaction to store these event
> > types, otherwise, we cannot distinguish the event type for the samples.
> 
> I'm not familiar with the meaning of transactions in this context, but
> I agree giving visibility of these remaining events is a good idea. I'm
> just unsure where to place them from the available --itrace options.

Please take a look in my another reply, I think it's good to consider
to use event type + sample fields (flags/data_src/transactions) for
better expressing samples.

> Regarding the "all" events, we thought having quick access to a  global
> histogram of all the spe events is useful, and from all the --itrace
> options it seemed to fit best under --itrace=o.

Okay, I agree this is a distinct requirement and we can use this way
to generate for all SPE records.  But the question is if a user reviews
"all" events, how user can easily understand the samples if only bases
on fields sample::addr, e.g. we will have no idea if a sample is a
memory operation or a branch operation, and I think the samples for
memory operations will always set sample.addr as 0.

Thanks,
Leo
