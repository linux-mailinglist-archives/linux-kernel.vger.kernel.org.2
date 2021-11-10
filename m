Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F2344C474
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhKJPfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbhKJPfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:35:40 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ADBC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:32:52 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u25so3351363ljo.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgnxHpODLfO97J2yEr0Lgc9c26Tdre2cWAJCLwwYcLE=;
        b=fa5BPQDJ3MCjtDnhVvoTCstK7EKMlBcs6VwSYsuGhukmLU8n5C5WoA8OzDj00ZYOiz
         hqsBn0HgpxlSnjEvK064oBdIhzHlBqiHP9yV1kQtUqFTSbY3545FcjomZ+SUTrrPT+PK
         hwT2SPSiHKPGvt+Wr/LGGCKLZdi3eDB+V+8yqXwiwnkrcwPMOd8J7d4/aXZu0q5JFvUv
         HCZuJTXtNYJUoJJtwqESWaKpiuh4TNG0fsQgw3DfvexwLXsBYUW4/jyn2ZV8T56bQ1YA
         jDSzHiW2PfHLz/4nkiJQbybbbQImYH8DfVnSr99AN7/M5CQIUHg80XR8NyRGvNHewyvV
         cLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgnxHpODLfO97J2yEr0Lgc9c26Tdre2cWAJCLwwYcLE=;
        b=ap/XxT22DwjSIZWcMzTqESHqaGCy2t9CwJ9OQbBCcM8hDg6VTXLgMZNhA1gsYpS4VC
         63oTDQcw5lZjeNeRIg5I5eDUnMx7QNwQpg8h7zYgC2wd4+mmEIFCulU1UfUIagR4Mofh
         oRIQvUASCstUac/Cy7f6P6BvucPoXVVxFfFW61FZLRRxqsSd3l9EHhWdgISzfBPkeD7x
         Zg3P5e89X+pkOuR2DJC3zwe9yuvhb6uCs1GJENNTLV0h7R9OlhkMq2uyQsMUtqH170nK
         HGsojtM6I7zrrGh6wLm0YeLPlwu4cGg7QN7CudJuU+ECG7foFyWF8KZm3IZnBqC3WONt
         /c6w==
X-Gm-Message-State: AOAM531am0rG5nDgQjP/pBmefDl4jnut49hQ72LC2ZWR8niBNiY4BeH3
        QtM8xgg/0wG41Liv1uLmQIoj3Teq1LLg+lltK2IVLw==
X-Google-Smtp-Source: ABdhPJyEiu7DvQleXm6qr5yt7Ynnf9cbec/8aIllgbxX+RUZq1gRRznfC5YDIgaCRimVmMWiCa56JaKo4c7c0qOYtsY=
X-Received: by 2002:a05:651c:1035:: with SMTP id w21mr292598ljm.278.1636558370438;
 Wed, 10 Nov 2021 07:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20211102142331.3753798-1-pgonda@google.com> <20211102142331.3753798-5-pgonda@google.com>
 <YYquDWbkIwCkixxD@google.com> <CAMkAt6rHdsdD-L4PbZL7qaOY7GRHmApVJam0V0yY2BnYdhmPjA@mail.gmail.com>
 <YYrZXRTukz3RccPN@google.com> <CAMkAt6qauoiTBXF9VXRGiqtJD5pTAV=NqKHZgNFXHCkrR50gkg@mail.gmail.com>
 <eff7a2cb-f78a-646a-dc0c-b24998e9e9af@amd.com>
In-Reply-To: <eff7a2cb-f78a-646a-dc0c-b24998e9e9af@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 10 Nov 2021 08:32:38 -0700
Message-ID: <CAMkAt6rj94Mzb6HBaqQbi7HHfhS4q1O4fxO8M7Xe=TZeZ0zZOg@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] crypto: ccp - Add SEV_INIT_EX support
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>, Thomas.Lendacky@amd.com,
        David Rientjes <rientjes@google.com>,
        Marc Orr <marcorr@google.com>, Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 3:20 PM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
>
>
> On 11/9/21 2:46 PM, Peter Gonda wrote:
> > On Tue, Nov 9, 2021 at 1:26 PM Sean Christopherson <seanjc@google.com> wrote:
> >>
> >> On Tue, Nov 09, 2021, Peter Gonda wrote:
> >>> On Tue, Nov 9, 2021 at 10:21 AM Sean Christopherson <seanjc@google.com> wrote:
> >>>> There's no need for this to be a function pointer, and the duplicate code can be
> >>>> consolidated.
> >>>>
> >>>> static int sev_do_init_locked(int cmd, void *data, int *error)
> >>>> {
> >>>>          if (sev_es_tmr) {
> >>>>                  /*
> >>>>                   * Do not include the encryption mask on the physical
> >>>>                   * address of the TMR (firmware should clear it anyway).
> >>>>                   */
> >>>>                  data.flags |= SEV_INIT_FLAGS_SEV_ES;
> >>>>                  data.tmr_address = __pa(sev_es_tmr);
> >>>>                  data.tmr_len = SEV_ES_TMR_SIZE;
> >>>>          }
> >>>>          return __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
> >>>> }
> >>>>
> >>>> static int __sev_init_locked(int *error)
> >>>> {
> >>>>          struct sev_data_init data;
> >>>>
> >>>>          memset(&data, 0, sizeof(data));
> >>>>          return sev_do_init_locked(cmd, &data, error);
> >>>> }
> >>>>
> >>>> static int __sev_init_ex_locked(int *error)
> >>>> {
> >>>>          struct sev_data_init_ex data;
> >>>>
> >>>>          memset(&data, 0, sizeof(data));
> >>>>          data.length = sizeof(data);
> >>>>          data.nv_address = __psp_pa(sev_init_ex_nv_address);
> >>>>          data.nv_len = NV_LENGTH;
> >>>>          return sev_do_init_locked(SEV_CMD_INIT_EX, &data, error);
> >>>> }
> >>>
> >>> I am missing how this removes the duplication of the retry code,
> >>> parameter checking, and other error checking code.. With what you have
> >>> typed out I would assume I still need to function pointer between
> >>> __sev_init_ex_locked and __sev_init_locked. Can you please elaborate
> >>> here?
> >>
> >> Hmm.  Ah, I got distracted between the original thought, the realization that
> >> the two commands used different structs, and typing up the above.
> >>
> >>> Also is there some reason the function pointer is not acceptable?
> >>
> >> It's not unacceptable, it would just be nice to avoid, assuming the alternative
> >> is cleaner.  But I don't think any alternative is cleaner, since as you pointed
> >> out the above is a half-baked thought.
> >
> > OK I'll leave as is.
> >
> >>
> >>>>> +     rc = init_function(error);
> >>>>>        if (rc && *error == SEV_RET_SECURE_DATA_INVALID) {
> >>>>>                /*
> >>>>>                 * INIT command returned an integrity check failure
> >>>>> @@ -286,8 +423,8 @@ static int __sev_platform_init_locked(int *error)
> >>>>>                 * failed and persistent state has been erased.
> >>>>>                 * Retrying INIT command here should succeed.
> >>>>>                 */
> >>>>> -             dev_dbg(sev->dev, "SEV: retrying INIT command");
> >>>>> -             rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
> >>>>> +             dev_notice(sev->dev, "SEV: retrying INIT command");
> >>>>> +             rc = init_function(error);
> >>>>
> >>>> The above comment says "persistent state has been erased", but __sev_do_cmd_locked()
> >>>> only writes back to the file if a relevant command was successful, which means
> >>>> that rereading the userspace file in __sev_init_ex_locked() will retry INIT_EX
> >>>> with the same garbage data.
> >>>
> >>> Ack my mistake, that comment is stale. I will update it so its correct
> >>> for the INIT and INIT_EX flows.
> >>>>
> >>>> IMO, the behavior should be to read the file on load and then use the kernel buffer
> >>>> without ever reloading (unless this is built as a module and is unloaded and reloaded).
> >>>> The writeback then becomes opportunistic in the sense that if it fails for some reason,
> >>>> the kernel's internal state isn't blasted away.
> >>>
> >>> One issue here is that the file read can fail on load so we use the
> >>> late retry to guarantee we can read the file.
> >>
> >> But why continue loading if reading the file fails on load?
> >>
> >>> The other point seems like preference. Users may wish to shutdown the PSP FW,
> >>> load a new file, and INIT_EX again with that new data. Why should we preclude
> >>> them from that functionality?
> >>
> >> I don't think we should preclude that functionality, but it needs to be explicitly
> >> tied to a userspace action, e.g. either on module load or on writing the param to
> >> change the path.  If the latter is allowed, then it needs to be denied if the PSP
> >> is initialized, otherwise the kernel will be in a non-coherent state and AFAICT
> >> userspace will have a heck of a time even understanding what state has been used
> >> to initialize the PSP.
> >
> > If this driver is builtin the filesystem will be unavailable during
> > __init. Using the existing retries already built into
> > sev_platform_init() also the file to be read once userspace is
> > running, meaning the file system is usable. As I tried to explain in
> > the commit message. We could remove the sev_platform_init call during
> > sev_pci_init since this only actually needs to be initialized when the
> > first command requiring it is issues (either reading some keys/certs
> > from the PSP or launching an SEV guest). Then userspace in both the
> > builtin and module usage would know running one of those commands
> > cause the file to be read for PSP usage. Tom any thoughts on this?
> >
>
> One thing to note is that if we do the INIT on the first command then
> the first guest launch will take a longer. The init command is not
> cheap (especially with the SNP, it may take a longer because it has to
> do all those RMP setup etc). IIRC, in my early SEV series in I was doing
> the INIT during the first command execution and based on the
> recommendation moved to do the init on probe.
>
> Should we add a module param to control whether to do INIT on probe or
> delay until the first command ?

Thats a good point Brijesh. I've only been testing this with SEV and
ES so haven't noticed that long setup time. I like the idea of a
module parameter to decide when to INIT, that should satisfy Sean's
concern that the user doesn't know when the INIT_EX file would be read
and that there is extra retry code (duplicated between sev_pci_init
and all the PSP commands). I'll get started on that.

>
> -Brijesh
