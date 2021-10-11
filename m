Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29E64297DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 21:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhJKT6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 15:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234763AbhJKT6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 15:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633982205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XPKvsjl8YoFxqfpp2DVkXZObdp8Zqyql8QX88E6eqok=;
        b=Iq4X/sC3FRHAQeoQefPKsF7c1kGRVQpiyFkud8cVZSbK5myc56/WKNr24Q4bd5e9Cl7rSP
        ascnyEhpD6KsnjUgBX/26RtJnWZLEO+3yQ2YcQxZDj74sYq3TMEnlQVMMMcPrqMAlSyVHQ
        IJorUw4OdrEiRGPeAm5fmPCIzKpjkrI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-1mDduGuFOpeu-UK3291hLw-1; Mon, 11 Oct 2021 15:56:44 -0400
X-MC-Unique: 1mDduGuFOpeu-UK3291hLw-1
Received: by mail-ed1-f71.google.com with SMTP id f4-20020a50e084000000b003db585bc274so11205492edl.17
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XPKvsjl8YoFxqfpp2DVkXZObdp8Zqyql8QX88E6eqok=;
        b=vbDopioAcMaXyRH2892kQvKsMqf0XxDC8r7T+UIUpOxthQghJwYjIpDofdh1WT4Gj9
         gTrTUewEbipdYj2MI+j+DZmeC95VRaST4zMZXrtCMbdTFB8DsL8GgJKbT7aWOftYsTJm
         qwAKjaFZExIT2lEHQAQ6NSPM1nOVclscQMI3P5plfVgn5jIRRUy9/jurRgRPZUtEHYFQ
         eHgPuASSOrHaOxljRslQRJkfo46OJVHwFKbht0sDGeEnu4s0bbCNGIE2H07G5bcRU1jz
         EAlgpEhTYWtNh2y3dlCwZHGt51Jr4j5rH1rwjVRMF6Lq8+zlmzQTwxtnqgDc/7ZLh3xp
         n9lw==
X-Gm-Message-State: AOAM5328mgL0Et1gxqfEyLjp2Y9/fpU7YkBOY6sdX0xoqqWxj5bAL/9t
        soR1qhoZSrkba38HIJBwv8hBmkc84UaCrJl1f9PdURaXRPEdaQHcNL6Rsslk1j/RDNFm8ppns2H
        5KbHW9Nv97oeJbf5gLMOycrpM
X-Received: by 2002:a17:906:d96a:: with SMTP id rp10mr28022590ejb.497.1633982202923;
        Mon, 11 Oct 2021 12:56:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGZ3jPvs4mi57pN4IcTRUYnV+aiSZ94qB6dOZ+sdw++yf0nSx92VTVuWZOO18cEogp0kc1LQ==
X-Received: by 2002:a17:906:d96a:: with SMTP id rp10mr28022571ejb.497.1633982202722;
        Mon, 11 Oct 2021 12:56:42 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id p22sm3970825ejl.90.2021.10.11.12.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 12:56:42 -0700 (PDT)
Date:   Mon, 11 Oct 2021 21:56:40 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v3 6/8] perf session: Move event read code to separate
 function
Message-ID: <YWSW+PLDJJlkjlXz@krava>
References: <cover.1633596227.git.alexey.v.bayduraev@linux.intel.com>
 <6ab47325fa261deca4ca55ecacf1ca2437abcd78.1633596227.git.alexey.v.bayduraev@linux.intel.com>
 <YV/0ZZBu01V87A8e@krava>
 <aa62d0ed-abca-2123-c8bf-cd6bced2fe9c@linux.intel.com>
 <YWBX+p1vtLXXbpkF@krava>
 <5e5ecfcd-57f1-1a06-4ed6-6a1e6983d1f8@linux.intel.com>
 <f8d0accb-b569-3fcd-ffe5-99e2fab4c8b7@linux.intel.com>
 <YWQ6TyyYRfx9AXLH@krava>
 <d630cf0d-1bb5-0527-411a-c70a01e2ddea@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d630cf0d-1bb5-0527-411a-c70a01e2ddea@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 07:40:33PM +0300, Bayduraev, Alexey V wrote:
> 
> 
> On 11.10.2021 16:21, Jiri Olsa wrote:
> > On Mon, Oct 11, 2021 at 12:53:30PM +0300, Bayduraev, Alexey V wrote:
> >>
> >>
> >> On 11.10.2021 12:08, Bayduraev, Alexey V wrote:
> >>>
> >>> On 08.10.2021 17:38, Jiri Olsa wrote:
> >>>> On Fri, Oct 08, 2021 at 11:42:18AM +0300, Bayduraev, Alexey V wrote:
> >>>>>
> >>>>>
> >>>>> On 08.10.2021 10:33, Jiri Olsa wrote:
> >>>>>> On Thu, Oct 07, 2021 at 01:25:41PM +0300, Alexey Bayduraev wrote:
> >>>>>>
> >>>>>> SNIP
> >>>>>>
> >>>>>>>  static int
> >>>>>>> -reader__process_events(struct reader *rd, struct perf_session *session,
> >>>>>>> -		       struct ui_progress *prog)
> >>>>>>> +reader__read_event(struct reader *rd, struct perf_session *session,
> >>>>>>> +		   struct ui_progress *prog)
> >>>
> >>> SNIP
> >>>
> >>>>>>
> >>>>>> active_decomp should be set/unset within reader__process_events,
> >>>>>> not just for single event read, right?
> >>>>>
> >>>>> No, it should be set before perf_session__process_event/process_decomp_events
> >>>>> and unset after these calls. So active_decomp setting/unsetting is moved in
> >>>>> this patch to the reader__read_event function. This is necessary for multiple
> >>>>> trace reader because it could call reader__read_event in round-robin manner.
> >>>>
> >>>> hum, is that code already in? I can't see this happening in current code
> >>>
> >>> Probably I don't understand the question. In [PATCH v3 2/8] I introduced 
> >>> active_decomp pointer in perf_session. It is initialized by a pointer to the 
> >>> decompressor object in perf_session. In reader__process_events it is set to 
> >>> the reader decompressor object. And it is reset to the session decompressor 
> >>> object at exit. In this case we do not need to reset it after each 
> >>> perf_session__process_event because this code reads events in loop with 
> >>> constant reader object. Maybe setting of active_decomp should be at the 
> >>> entrance to the reader__process_events, not before reader__process_events, 
> >>> in [PATCH v3 2/8]. All this code is new.
> >>
> >> We set active_decomp for perf_session__process_event (rd->process() in our
> >> case) and for __perf_session__process_decomp_events, active_decomp is not 
> >> necessary for other parts of reader__process_events.
> > 
> > so what I see in the code is:
> > 
> > __perf_session__process_events
> > {
> > 	struct reader rd;
> > 
> > 	reader__process_events(rd)
> > 	{
> > 		reader__read_event(rd)
> > 		{
> > ->			session->active_decomp = &rd->decomp_data;
> > 			rd->process(...
> > ->			session->active_decomp = &session->decomp_data;
> > 		}
> > 
> > 	}
> > }
> > 
> > 
> > we set session->active_decomp for each event that we process
> > and I don't understand why we can't do that just once in
> > __perf_session__process_events, so it'd be like:
> > 
> > __perf_session__process_events
> > {
> > 	struct reader rd;
> > 
> > ->	session->active_decomp = &rd->decomp_data;
> > 
> > 	reader__process_events(rd)
> > 	{
> > 		reader__read_event(rd)
> > 		{
> > 			rd->process(...
> > 		}
> > 
> > 	}
> > 
> > ->	session->active_decomp = &session->decomp_data;
> > }
> > 
> > 
> > or within reader__process_events if it's more convenient
> 
> Now I got it, thanks ;)
> 
> With your suggestion, for multiple trace reader, we should always 
> remember to switch active_decomp when switching the reader object, 
> just passing the current reader pointer to the reader__read_event 
> function will not be enough. I thought it would be better to hide 
> such details in the reader__read_event function.
> 
> Of course, I can move setting of active_decomp outside of 
> reader__read_event if this is better from your point of view.

at the moment it's not necessary to set/unset it for each event,
let's do that when it's really needed in the following changes
for threaded perf record with explanation

thanks,
jirka

> 
> Regards,
> Alexey
> 
> > 
> > jirka
> > 
> >>
> >> Regards,
> >> Alexey
> >>
> >>>
> >>> In this patch I separates single event reading and moves setting/resetting
> >>> of active_decomp before/after perf_session__process_event because this is 
> >>> necessary for multiple trace reader. 
> >>>
> >>> Regards,
> >>> Alexey
> >>>
> >>>>
> >>>> jirka
> >>>>
> >>>>>
> >>>>> Regards,
> >>>>> Alexey
> >>>>>
> >>>>>>
> >>>>>> jirka
> >>>>>>
> >>>>>>>  	return err;
> >>>>>>>  }
> >>>>>>>  
> >>>>>>> -- 
> >>>>>>> 2.19.0
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>
> > 
> 

