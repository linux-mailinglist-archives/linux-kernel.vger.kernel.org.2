Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F645400DDA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 05:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhIEDV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 23:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhIEDV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 23:21:28 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166E9C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 20:20:25 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d11so2791022qtw.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 20:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qU6Y5BvgW/rXpEywDS1N1SXuTjFAvwE2ogv1Ewyo6DQ=;
        b=OdWXnjAo52ghmBsy3VN3sjMPcV/oyeinoKyuUCIK9wWB2cJ2nQWY/xgxFUsf8ukswJ
         Oo+rivxXeEVafIZxjz3MFKiJgv6WkRpXrcDa/URn10Vlbb9qeJHz6rMTTZvJhZmkU6oq
         q2jHLIPJtQUHDLTe81pCHWC3D1WnKLwi6lm0/jPZ7m2dEc66mA9VgpMNg7XzkNl0OLef
         kQ3edHVvmf+lMAbF0rdFv60q6jczj4/C6udIu4fVl0kTvmbWrEcHG6UjTiuFDquZ9Hic
         F3uLatCONt2ietvxtz9EpAnyuVZNbsJJSvgKFYl6+Zx7gMLh7mb+uKYe3ywKkqF/irzy
         8KCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qU6Y5BvgW/rXpEywDS1N1SXuTjFAvwE2ogv1Ewyo6DQ=;
        b=fQuxwSeENW9rKbM0ew2rumZGIHuoT2U11KVzNHzirHA/3hkoh6nXiuqUcqMQON+upV
         Jt8laOo/yu6drOx26DXrWYv0gdMMmhjILN8rF+sQYsmvM3XuG02qFPOKmURhcFUJIUl6
         C96uN9wkttlJZQFoEuXB45ADM7kKfPPUEfrBGx0jYw4FzSaioNe7pxrxRxAl6dJRzJCd
         ORhjTKaUsA5kIhvnpdBinfkLXytnc8C+0sFSOpw60EJFYjR+aTRkByPBwFEBsp8PAmoT
         U4Ll3Kz7lVZxxddRLsbTHchBKpVctHocvpJC2rm+xF9lzT3VyGltvzN8dKV8oeWZX6nn
         pwJw==
X-Gm-Message-State: AOAM533WhvF6fSj4TcCxUgv+5Ak0zRek8t/LVaPrzPtrJOzxfpZcGTSb
        Ttc2hlWwcwf28SGIdPNJ5dA=
X-Google-Smtp-Source: ABdhPJzal7FC6mRY1lKeECV6n5STtIu+LvYZZb0fI7TRl9hdy8wlvmD+Emvhh+XbWPrMbmXCq1x6/Q==
X-Received: by 2002:ac8:701b:: with SMTP id x27mr5882724qtm.270.1630812024060;
        Sat, 04 Sep 2021 20:20:24 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id s18sm2833523qtn.46.2021.09.04.20.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 20:20:23 -0700 (PDT)
Date:   Sat, 4 Sep 2021 20:20:21 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Down <chris@chrisdown.name>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Ingo Molnar <mingo@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [PATCH v2 1/2] lib: add sputchar() helper
Message-ID: <YTQ3dQSmougYRDA9@yury-ThinkPad>
References: <20210904231020.331185-1-yury.norov@gmail.com>
 <20210904231020.331185-2-yury.norov@gmail.com>
 <a109e614f82891ef6e99b0ab3535a90ccaf04181.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a109e614f82891ef6e99b0ab3535a90ccaf04181.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2021 at 06:36:41PM -0700, Joe Perches wrote:
> On Sat, 2021-09-04 at 16:10 -0700, Yury Norov wrote:
> > There are 47 occurrences of the code snippet like this:
> > 	if (buf < end)
> > 	        *buf = ' ';
> > 	++buf;
> > 
> > This patch adds a helper function sputchar() to replace opencoding.
> > It adds a lot to readability, and also saves 43 bytes of text on x86.
> 
> I think this patch does little to improve readability.
> 
> Perhaps make it void and use something like
> 
> 	sputchar(*buf++, end, <whateverchar>);

It's better, thank you.
 
> Though the sputchar name doesn't seems particularly intelligible.

I'm OK with any better name.

Thanks,
Yury

> > +static inline char *sputchar(char *buf, const char *end, char c)
> > +{
> > +	if (buf < end)
> > +		*buf = c;
> > +
> > +	return buf + 1;
> > +}
> > +
> >  /*
> >   * General tracing related utility functions - trace_printk(),
> >   * tracing_on/tracing_off and tracing_start()/tracing_stop
> > diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> []
> > @@ -335,12 +335,8 @@ static bool escape_space(unsigned char c, char **dst, char *end)
> >  		return false;
> >  	}
> > 
> > -	if (out < end)
> > -		*out = '\\';
> > -	++out;
> > -	if (out < end)
> > -		*out = to;
> > -	++out;
> > +	out = sputchar(out, end, '\\');
> > +	out = sputchar(out, end, to);
> 
> etc...
> 
