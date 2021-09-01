Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA103FE53C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 00:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244062AbhIAWHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhIAWHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:07:40 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DFDC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 15:06:43 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id c6so1536562ybm.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 15:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhHElbfFehHKR3iF8SjK6BzG55GVC5uj/uW8uuku34I=;
        b=Jt+zbafJukyb0oTQNCARSLXW94BfRLmfGcAx4WqUP7jFs3Ed+ktuvcRGjHFfqahrps
         Q3/tqdEZPD5pKAwd7/zdcNmMTmE+TtBVKs++JMEHpTaZfv/KH+m8niK7EhUkCEHxwKp1
         dKpzGBXCWgnOGyWnobIQPXdaN/y0bLTP0fkDGx4+RIotuG5fBcFPyTfweYDWfCT/NexZ
         aZESZPehJBU0NXoijSWtwvqa4JxkXpCoKkw32Gu9RuQjADJbDcRc7BVQuNAp0CCaCBSq
         nW3EVMPVi3aCDDxo2CjKMugrcjmIFlT8OGtiTacdwuRU7Ud0G2FKkrGmG+HV4jDtELWf
         ZmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhHElbfFehHKR3iF8SjK6BzG55GVC5uj/uW8uuku34I=;
        b=ClZwFDxdWUW0i5XAESmAh4HE/SAO8BRWNFCqKYP2J9l0TI1KO2MNLFsIqdFTtqK6Uh
         t9ssDfGsVB/RlSFfxzom2wJiTTGZvw9eXhp3+YOEhOgKE7RtiPn1q82LsnsqBW+Z8gQV
         FJkjMn96YoQKAU6UIuz5mhMy9N4CnRSBk+2rHIbBGoz/BAhvknenTRV8QifGvyXI9FDM
         gYBYEi8B+FHwHu6wdcJ5EXVxXYE+kwBdlMlbyX/EoEzp95QWHK0iHvlL2pm9m178IbL9
         BOquYNb/pLkb1S3Q5JQ8X5XmEtWgjh8J/FjbWLMrL6Zg2vraRGjIY1ApD6phDOwPzrNS
         JfJg==
X-Gm-Message-State: AOAM532aZcq7FLkh2srDqdHC9Ks4zv9M7XeHwt2Cvb5lSclmEACyo6cn
        6EsPbQfogSqehDQV/QdoxsYoWym3Wcp2VwzGQ1FKLw==
X-Google-Smtp-Source: ABdhPJzdE/jOrGHc6mdiB3i581lBRbbEklCVTghV//HVNGyeQM77WKx6k/+7KCiSjTrt4i6KjAsgFj122PiroUtQ1BY=
X-Received: by 2002:a25:6746:: with SMTP id b67mr201599ybc.96.1630534002224;
 Wed, 01 Sep 2021 15:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210831102125.624661-1-ulf.hansson@linaro.org>
 <CAGETcx868QWj0jMJ+U-eL62jT-LO_LTOw5EcwEKptfFOVa=A5A@mail.gmail.com>
 <CAPDyKFopTW=ZoB9FYJ-ozRZTnJDTT_gFtz0XDiU-weYb1Q9bkQ@mail.gmail.com>
 <CAGETcx_e7kCQ_0yC9=k1jzjJJEqdOMuA=JkD81=2-Nb4fcS0+w@mail.gmail.com> <CAPDyKFranX4Yz8546C1E3Gq_ZkQi34Xb=Rxi5mPtw-s_J1QPoQ@mail.gmail.com>
In-Reply-To: <CAPDyKFranX4Yz8546C1E3Gq_ZkQi34Xb=Rxi5mPtw-s_J1QPoQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Sep 2021 15:06:06 -0700
Message-ID: <CAGETcx_DXQyaH2te1cxV+yCS+kdfjWOFbxQkhEKCbXtU0FWS1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: property: fw_devlink: Rename 'node_not_dev' to 'optional_con_dev'
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, DTML <devicetree@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 2:27 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 1 Sept 2021 at 22:56, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Wed, Sep 1, 2021 at 12:45 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Tue, 31 Aug 2021 at 19:31, Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Tue, Aug 31, 2021 at 3:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > In the struct supplier_bindings the member 'node_not_dev' is described as
> > > > > "The consumer node containing the property is never a device.", but that
> > > > > doesn't match the behaviour of the code in of_link_property().
> > > > >
> > > > > To make the behaviour consistent with the description, let's rename the
> > > > > member to "optional_con_dev" and clarify the corresponding comment.
> > > > >
> > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > ---
> > > > >  drivers/of/property.c | 9 +++++----
> > > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > index 6c028632f425..2babb1807228 100644
> > > > > --- a/drivers/of/property.c
> > > > > +++ b/drivers/of/property.c
> > > > > @@ -1249,7 +1249,8 @@ static struct device_node *parse_##fname(struct device_node *np,       \
> > > > >   * @parse_prop.index: For properties holding a list of phandles, this is the
> > > > >   *                   index into the list
> > > > >   * @optional: Describes whether a supplier is mandatory or not
> > > > > - * @node_not_dev: The consumer node containing the property is never a device.
> > > > > + * @optional_con_dev: The consumer node containing the property may not be a
> > > > > + *                   device, then try finding one from an ancestor node.
> > > >
> > > > Nak. This flag is not about "may not be". This is explicitly for
> > > > "never a device". It has to do with stuff like remote-endpoint which
> > > > is never listed under the root node of the device node. Your
> > > > documentation change is changing the meaning of the flag.
> > >
> > > Okay, fair enough.
> > >
> > > Although, as stated in the commit message this isn't the way code
> > > behaves. Shouldn't we at least make the behaviour consistent with the
> > > description of the 'node_not_dev' flag?
> >
> > I know what you mean, but if you use the flag correctly (where the
> > phandle pointed to will never be a device with compatible property),
> > the existing code would work correctly. And since the flag is relevant
> > only in this file, it's easy to keep it correct. I'd just leave it as
> > is.
>
> Sorry, but that just sounds lazy to me, I am sure we can do better.
> The current code and the name of the flag is confusing, at least to me
> (and I bet to others as well).
>
> Moreover, I don't quite understand your objections to changing this.
> Why leave this to be inconsistent when it can be easily fixed?

If you feel so strong about it, go for it. No strong objections. Just
double check the refcounts are done correctly.

-Saravana
