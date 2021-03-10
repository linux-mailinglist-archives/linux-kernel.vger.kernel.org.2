Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6393335D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 07:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhCJGbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 01:31:18 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:33923 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhCJGbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 01:31:04 -0500
Received: by mail-lf1-f45.google.com with SMTP id v9so31610326lfa.1;
        Tue, 09 Mar 2021 22:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=SQjZfi/dxS7pbX1/QbOyX75MPoZnzUf1tDX2S+jzZ0o=;
        b=l4xCeaYxouReBrIQnwdqn9Etz3pHPfXF1CdLpB1DMvQLbeLp2NYuNqlcjkGmz8mZCu
         /hM+5yDcJg6a6Nyl6caKk/eLfDj0C7SSNkG8v19HMfwEWvhyLcWftJzs+83ec4DGyao7
         zlq9AH0eszpkFWMA3oPKdOoY9fieBpaieHLSgJDvDZ3ewpT/Ch+38hS7+npMeUAOnerk
         OKRGYrOoK/qgf8pKY2q6/8zkzSAZ1mUqxJ+cDsYhX7PxmSgHlM/cUy+IqbFuaQQtzLDp
         yBPxmqYMcQLLioiy5sL5PTevSnQkbKD6PTNIbSnewuPMClUopr7TjUwlfvCW/wKWywse
         Q1tg==
X-Gm-Message-State: AOAM5308nH4AOBAnODWYOhDo+eYxooJF+aBxuN2PaW5czeX4do99cCve
        HyXK6HvTxpUJcy7uALOJ/nYL2fs95dQ=
X-Google-Smtp-Source: ABdhPJwj66brRUopo895T2kyFSOnDnReEkubGIDImFNa2zALznwt2eHkPWX/Se3M2TCG7frcHlmOfA==
X-Received: by 2002:a05:6512:3301:: with SMTP id k1mr1130074lfe.327.1615357862967;
        Tue, 09 Mar 2021 22:31:02 -0800 (PST)
Received: from dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id u3sm2560248lff.225.2021.03.09.22.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 22:31:02 -0800 (PST)
Message-ID: <dffaa91e826647723de9c7ada1de6bd9b51365c9.camel@fi.rohmeurope.com>
Subject: Re: [PATCH v3 05/15] dt_bindings: mfd: Add ROHM BD71815 PMIC
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
In-Reply-To: <CAL_JsqKbZzXBMPH_aus7=xZWn-EY0BBVnVbu0W_EO_US7vbJNA@mail.gmail.com>
References: <cover.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
         <790da5fe60eb3bcd190830770866147bbb5f8143.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
         <20210308173938.GA2679675@robh.at.kernel.org>
         <06c8e7339ebc3e1802aa1e9c213de9392671a8a5.camel@fi.rohmeurope.com>
         <CAL_JsqKbZzXBMPH_aus7=xZWn-EY0BBVnVbu0W_EO_US7vbJNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Wed, 10 Mar 2021 08:30:57 +0200
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

(I dropped other personal mails from CC - kept only the lists)

On Tue, 2021-03-09 at 08:11 -0700, Rob Herring wrote:
> On Tue, Mar 9, 2021 at 5:51 AM Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> > Hello Rob,
> > 
> > On Mon, 2021-03-08 at 10:39 -0700, Rob Herring wrote:
> > > On Mon, 08 Mar 2021 12:40:50 +0200, Matti Vaittinen wrote:
> > > > 
> > > dtschema/dtc warnings/errors:
> > > Unknown file referenced: [Errno 2] No such file or directory:
> > > '/usr/local/lib/python3.8/dist-
> > > packages/dtschema/schemas/regulator/rohm,bd71815-regulator.yaml'
> > 
> > This bothers me slightly. The patch 04/15 should bring-in the
> > rohm,bd71815-regulator.yaml. Does this error indicate that file is
> > missing or is my $ref somehow invalid?
> 
> Then it's simply a false positive. I usually check these and try to
> only send the email if the dependency is not in the series so the
> dependency is clear. It's a balance of replying quickly and my time
> reviewing the errors.

Oh, good to know. I was assuming I got it wrong once again... Thanks!

Rest of the mail is further discussion why I wonder if yaml bindings
are worth it - you can skip it if you're not in a mood for babbling ;)

Best Regards
	Matti

> > *** opinion follows - not sure if it just me but... ***
> > 
> > I know I should probably keep my mouth shut but... I am more and
> > more
> > thinking that the yaml bindings are yet another 'excessive unit-
> > test'
> > type solution. Tooling which should "force doing things correctly"
> > is
> > eventually hindering development and causing the end result being
> > sub-
> > optimal.
> 
> It's about validating DTS files actually do what the bindings say.
> It's pretty clear that the free form text bindings left a lot of
> things ambiguous.
> 
> How would you propose we can check every property in a DTS file has a
> definition (minimally of it's type)? Freeform text can simply never
> do
> that.

True. But I am not at all sure that the benefit of verifying the .dts
files programmatically exceeds cost (work + lost readability for humans
+ impact of increased "not that fun" work). Anyways, as I wrote - this
is just my biased opinion. Other people may have different opinions :]

> > I mean that creating binding docs takes way too much time from
> > someone
> > like me who is "yaml-illiterate". And when I eventually get yaml
> > done -
> > the end result is far less descriptive for human eyes than the
> > "good
> > old" free-text format would've been. I know one can add comments -
> > but
> > I don't see much of them in the binding docs...
> 
> Because people do the minimum?

I know. This is the very basic nature of most human beings. I think
this must be accepted. And likelihood for doing bare minimum sky-
rockets when people feel the work they do is dull/boring/not fun. And I
just have a feeling that many who enjoy writing drivers find writing
the yaml bindings quite not fun. (I have absolutely no statistics to
back up this statement - it's just a feeling).

Big question is how to get best results in this not-so-perfect world
when we know that people are both lazy and make mistakes?

I have kind of deja-vu here. I've seen many attempts of tightening
mechanical checks to get rid of human errors. In my opinion it rarely
works well. To pick few I've seen:

- demand for 100 % UT test coverage.
	=> lazy people started to avoid code changes
	=> autogenerated test cases which assumed current code was
	   correct and brought no value but incredible inertia to all 
	   changes.
- demand for heavy(ish) RCA/EDA process when severe faults were fixed
	=> lazy people started to mark severe faults as minor
- demand for peculiar, hard to remember syntax for commit messages to
automatically fill in different statistics/management data
	=> lazy people started to commit all changes in same category
	   (syntax they had memorized/had alias for).
- demand for DT docs which can be verified
	=> ... ?

Common thing is that all of these have valid, good intention - but
overhead of doing them exceeded the (visible) benefits and lazy people
tried to get around of them / did bare minimum. And as a side impact -
part of the work got more boring - which also has (bad) consequences.

I am not surprized if people try skipping creating DT docs. Or if the
people do bare minimum with the DT docs.

>  The only comments/description I object
> to are duplicating generic descriptions of common properties.

I know. And I don't think you are to blame here.

> There's certainly lots of things we could do. There are tools which
> generate pretty docs out of json-schema. Not sure how useful they
> would be OOTB. But I simply don't have the bandwidth to look into
> them. I can barely keep up with reviews...

Yes. I understand this. And now I am just taking more of that time -
sorry. I just gave an opinion (knowing it probably won't change
anything - but at least I've told what I am afraid of).

Thanks for the open discussion :) I appreciate it. And I do really
admire the amount of effort you (have) put in this! I do also admire
your skills here. And I absolutely respect your opinions what comes to
how the DT should look like. I just see the usefulness of the bindings
verification differently. I hope you don't find this as a personal
attack.



