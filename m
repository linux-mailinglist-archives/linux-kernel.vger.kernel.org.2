Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786BA32D7EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbhCDQfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbhCDQev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:34:51 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06BDC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 08:34:10 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t9so6909568pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T8/EgYi/SDAkS2DArxnLA7mTNOBdeBCsibbsMl6AXjQ=;
        b=sRZ/s2TakknQC8HAIbiL+gTt6oLqDzQPtZJPo5ZOHg5sWefTMWgNGOzT936kbbeYvg
         U8fk/Z/PRsqbL5pyoLuwPNSj3faEsKrLZMh8opXvJk2M5yKwfQtG3zgs1WVxMzOej3jS
         No3CMUifStptckluGl9XfN22b04J90DJjZoRDv0mDHEAHFaJrXdXaTswcUcREkg6MMan
         pJxLJEP3NnSqC1cYT8JV1C90nwivLdvahuw/5hZNcF9EL8EOIprBdNByLDQd+6wk1rjO
         pjxH03ZcwOo94hvrjoB5WCxgxUZ2lV1RGLG8933/9O4Xsf7K6H3DE0kKEZG63sTTEIjI
         1y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T8/EgYi/SDAkS2DArxnLA7mTNOBdeBCsibbsMl6AXjQ=;
        b=U61rPzVuD/a38O/wmC0c8fjudzRK6grO+LDtnrafmNFRZMHQI0QyzSFqaEkYRFYHuN
         eK7HRMpqP9sW3WAuPRq4v8JYEVLlSXDB8PxX77MZQOPd2oZAk//I/LtdiO1ISqwt59We
         A/utVhF4O9DZr28qPb5i7VguRRup6XoCQPI2CncOykiE8MJzaxU+ST0dyTjC4ratpYVd
         6oniILw3izhdEoISSnFITnUtVCkdr1B/cviObrtKCk0/NO9rRGj/AliPYETSeNLMRLVE
         qbs4QrvbZBK9Rp4eLc+30uCgM5IuyyT/CXRu4prnwy/6Mz//d9IY1SwHZn8JgnT8uDxO
         33pw==
X-Gm-Message-State: AOAM53041o0Jsab94Md6OP3gV+G6wZVgULBnlk8ctM+vnVG0Zutcmgi6
        dNeTl+RV4wjniz3+3lVokSo=
X-Google-Smtp-Source: ABdhPJwKR0Zv0n8+XixNsVLzfMZECx9Xqx4ccz2mvvGMyUfqanym2Y2QDJ2Zk8W9rmxN/kPoduu+jw==
X-Received: by 2002:a17:90a:b287:: with SMTP id c7mr4446502pjr.206.1614875650391;
        Thu, 04 Mar 2021 08:34:10 -0800 (PST)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id v16sm26343351pfu.76.2021.03.04.08.34.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Mar 2021 08:34:10 -0800 (PST)
Date:   Thu, 4 Mar 2021 16:34:05 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf stat: improve readability of shadow stats
Message-ID: <20210304163404.zqiis33pvf6usdta@mail.google.com>
References: <20210301172402.6794-1-changbin.du@gmail.com>
 <YD0+OAH9Ytii3b3V@krava>
 <CAM9d7chzOv1cbu2i_6gc+C=yJ=P0VJbsYvEOvEKkXeunjYc3rw@mail.gmail.com>
 <YD4utPd12bVhH7Nx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD4utPd12bVhH7Nx@kernel.org>
User-Agent: NeoMutt/20180716-508-7c9a6d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 09:25:24AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 02, 2021 at 11:08:40AM +0900, Namhyung Kim escreveu:
> > On Tue, Mar 2, 2021 at 4:19 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Mar 02, 2021 at 01:24:02AM +0800, Changbin Du wrote:
> > > > This does follow two changes:
> > > >   1) Select appropriate unit between K/M/G.
> > > >   2) Use 'cpu-sec' instead of 'sec' to state this is not the wall-time.
> > > >
> > > > $ sudo ./perf stat -a -- sleep 1
> > > >
> > > > Before: Unit 'M' is selected even the number is very small.
> > > >  Performance counter stats for 'system wide':
> > > >
> > > >           4,003.06 msec cpu-clock                 #    3.998 CPUs utilized
> > > >             16,179      context-switches          #    0.004 M/sec
> > > >                161      cpu-migrations            #    0.040 K/sec
> > > >              4,699      page-faults               #    0.001 M/sec
> > > >      6,135,801,925      cycles                    #    1.533 GHz                      (83.21%)
> > > >      5,783,308,491      stalled-cycles-frontend   #   94.26% frontend cycles idle     (83.21%)
> > > >      4,543,694,050      stalled-cycles-backend    #   74.05% backend cycles idle      (66.49%)
> > > >      4,720,130,587      instructions              #    0.77  insn per cycle
> > > >                                                   #    1.23  stalled cycles per insn  (83.28%)
> > > >        753,848,078      branches                  #  188.318 M/sec                    (83.61%)
> > > >         37,457,747      branch-misses             #    4.97% of all branches          (83.48%)
> > > >
> > > >        1.001283725 seconds time elapsed
> > > >
> > > > After:
> > > > $ sudo ./perf stat -a -- sleep 2
> > > >
> > > >  Performance counter stats for 'system wide':
> > > >
> > > >           8,003.20 msec cpu-clock                 #    3.998 CPUs utilized
> > > >              9,768      context-switches          #    1.221 K/cpu-sec
> > > >                164      cpu-migrations            #   20.492  /cpu-sec
> > >
> > > should you remove also the leading '/' in ' /cpu-sec' ?
> > 
> > The change looks good.  And I think we should keep '/' otherwise it'd be
> > more confusing.
> 
> Perhaps:
> 
>            8,003.20 msec cpu-clock                 #    3.998 CPUs utilized
>               9,768      context-switches          #    1.221 K/cpu-sec
>                 164      cpu-migrations            #   20.492 /cpu-sec
> 
> ?
>
sure. Now it is:
$ sudo ./perf stat 
[sudo] password for changbin: 
^C
 Performance counter stats for 'system wide':

          6,046.61 msec cpu-clock                 #    3.999 CPUs utilized          
             7,569      context-switches          #    1.252 K/sec                  
               587      cpu-migrations            #   97.079 /sec                   
               229      page-faults               #   37.872 /sec                   
     1,484,855,385      cycles                    #    0.246 GHz                    
     2,112,863,483      stalled-cycles-frontend   #  142.29% frontend cycles idle   
     1,980,746,623      stalled-cycles-backend    #  133.40% backend cycles idle    
       454,477,035      instructions              #    0.31  insn per cycle         
                                                  #    4.65  stalled cycles per insn
        89,992,521      branches                  #   14.883 M/sec                  
         6,196,599      branch-misses             #    6.89% of all branches        

       1.512029866 seconds time elapsed

 
> - Arnaldo
>  
> > >
> > >
> > > SNIP
> > >
> > > > @@ -1270,18 +1271,14 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> > > >               generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
> > > >                               evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
> > > >       } else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
> > > > -             char unit = 'M';
> > > > +             char unit = ' ';
> > > >               char unit_buf[10];
> > > >
> > > >               total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);
> > > > -
> > > >               if (total)
> > > > -                     ratio = 1000.0 * avg / total;
> > > > -             if (ratio < 0.001) {
> > > > -                     ratio *= 1000;
> > > > -                     unit = 'K';
> > > > -             }
> > > > -             snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
> > > > +                     ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
> > > > +
> > > > +             snprintf(unit_buf, sizeof(unit_buf), "%c/cpu-sec", unit);
> > > >               print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
> > >
> > > hum this will change -x output that people parse, so I don't think we can do that
> > 
> > Agreed.
> > 
> > >
> > > >       } else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
> > > >               print_smi_cost(config, cpu, out, st, &rsd);
> > > > diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
> > > > index a46762aec4c9..ac13b5ecde31 100644
> > > > --- a/tools/perf/util/units.c
> > > > +++ b/tools/perf/util/units.c
> > > > @@ -55,6 +55,28 @@ unsigned long convert_unit(unsigned long value, char *unit)
> > > >       return value;
> > > >  }
> > > >
> > > > +double convert_unit_double(double value, char *unit)
> > > > +{
> > > > +     *unit = ' ';
> > > > +
> > > > +     if (value > 1000.0) {
> > > > +             value /= 1000.0;
> > > > +             *unit = 'K';
> > > > +     }
> > > > +
> > > > +     if (value > 1000.0) {
> > > > +             value /= 1000.0;
> > > > +             *unit = 'M';
> > > > +     }
> > > > +
> > > > +     if (value > 1000.0) {
> > > > +             value /= 1000.0;
> > > > +             *unit = 'G';
> > > > +     }
> > > > +
> > > > +     return value;
> > > > +}
> > >
> > > we have convert_unit function just above doing the same only with
> > > unsigned long.. let's have one base function with double values and
> > > another one casting the result to unsigned long
> > 
> > Sounds good.
> > 
> > Thanks,
> > Namhyung
> 
> -- 
> 
> - Arnaldo

-- 
Cheers,
Changbin Du
