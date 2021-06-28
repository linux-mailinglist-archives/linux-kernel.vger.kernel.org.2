Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A56A3B5D99
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhF1MKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbhF1MKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:10:35 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A38C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:08:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso10277916pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rBkm1+s9hX6PcUjinQ7lSJS/Fgd3FwweZh2+Z8xsqPo=;
        b=opd6sglrblljFRzHryg/7EDmSJHD5JrcCqUh9qzqAbDVm+/TtkkOtWQygN+1DkWBch
         AL45nqtkgOjaX1dUubd2kOvovFvWG6daiQBEHt119H2YFRS7/QXcRoKYQdjeBCeJ4s3d
         wGEzfk0U9N/+p7QxV1uMdyzpYfVi5uc+eqSlAjXvXRbRjUX0cmEYafIjy0gHuWuFhEWv
         D8a+oK8Nb9SH5DSPZUt/105BpunBxXb8WOPDQDC4roEBeRk7oE8WmqsbH3VRMhBV2vh3
         a3sEy3r6o49FJDybVNWviCMJ08pewDwPGjT+8pcaLWNLbboO2sQQYx4AcRk1aw7ZUOOs
         1fJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rBkm1+s9hX6PcUjinQ7lSJS/Fgd3FwweZh2+Z8xsqPo=;
        b=Krs+ibRapqQf0ku/iP8TEejy+ocv/RMEnFf8kL7z2IoVNHi7txfTWyGyGfaedqItHp
         +jgrPxGvqjJWw/KXSH3dpV44Ek45Zdd7k2n+qFTcWJPjfNjd/6XLH84iafTs0GP02hcv
         mrWgF8sDbRL/mbjRjjx5n7+3vRMO5I2TcjJFh7QOQYkMMm5LZZbxdQEGp0vinkQlOAMm
         ZOUaEYNw5+4Bbmq/K6UePgICrs9nENkspgWg87Q93kWwLyvuobP1sbpLJeo8pnEXE75B
         wUfJ06GyYr0lQNwUO6QpHWhlQviSlSvXIgH8KpY85418AUlYrvNr5h7/KSfhJUwYXYpu
         yJ8Q==
X-Gm-Message-State: AOAM530AvUPzMLnFBpX1kTvBD1Zqy3uq7IFDIXF2kiwlWtUyGwk5vojv
        FQTXYGQuiLFUDlXE2AF2iFfzJg==
X-Google-Smtp-Source: ABdhPJz+wogkKeCNY+BVjSj+kneg8FhgU/tquI+IyEsOosqz0f3FtnnoYWlFAZpKsenFk1uABafnlg==
X-Received: by 2002:a17:90a:2f66:: with SMTP id s93mr876153pjd.19.1624882089207;
        Mon, 28 Jun 2021 05:08:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id o1sm14404856pfk.152.2021.06.28.05.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:08:08 -0700 (PDT)
Date:   Mon, 28 Jun 2021 20:08:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] perf cs-etm: Split --dump-raw-trace by AUX records
Message-ID: <20210628120802.GC200044@leoy-ThinkPad-X240s>
References: <20210624164303.28632-1-james.clark@arm.com>
 <20210624164303.28632-3-james.clark@arm.com>
 <20210628012744.GA158794@leoy-ThinkPad-X240s>
 <c7906b72-e547-da37-c387-23de65831ac4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7906b72-e547-da37-c387-23de65831ac4@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 11:38:34AM +0100, James Clark wrote:

[...]

> >>  static int cs_etm__process_auxtrace_event(struct perf_session *session,
> >>  					  union perf_event *event,
> >>  					  struct perf_tool *tool __maybe_unused)
> >> @@ -2462,7 +2478,8 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
> >>  				cs_etm__dump_event(etm, buffer);
> >>  				auxtrace_buffer__put_data(buffer);
> >>  			}
> >> -	}
> >> +	} else if (dump_trace)
> >> +		dump_queued_data(etm, &event->auxtrace);
> > 
> > IIUC, in the function cs_etm__process_auxtrace_event(), since
> > "etm->data_queued" is always true, below flow will never run:
> > 
> >     if (!etm->data_queued) {
> >         ......
> > 
> >         if (dump_trace)
> >             if (auxtrace_buffer__get_data(buffer, fd)) {
> >                     cs_etm__dump_event(etm, buffer);
> >                     auxtrace_buffer__put_data(buffer);
> >             }
> >     }
> > 
> > If so, it's better to use a new patch to polish the code.
> > 
> 
> Hi Leo,
> 
> I think this is not true in piped mode because there is no auxtrace index.
> In that mode, events are processed only in file order and cs_etm__process_auxtrace_event()
> is called for each buffer.
> 
> You can reproduce this with something like this:
> 
>      ./perf record -o - ls > stdio.data
>      cat stdio.data | ./perf report -i -

You are right!  I tried these two commands with cs_etm event, just as
you said, in this case, the AUX trace data is not queued; so the flow
for "if (!etm->data_queued)" should be kept.  If so, I am very fine
for current change.  Thanks for sharing the knowledge.

> There are some other Coresight features that don't work as expected in this mode, like
> sorting timestamps between CPUs. The aux split patchset won't work either because random
> access isn't possible. And the TRBE patch that I'm working on now won't work, because it
> also requires the random access to lookup the flags on the AUX record to configure the 
> decoder for unformatted trace.

Cool, looking forward for the patches :)

Leo
