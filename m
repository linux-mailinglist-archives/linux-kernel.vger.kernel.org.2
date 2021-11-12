Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A7144EC29
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 18:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhKLRwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 12:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhKLRwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:52:18 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2AEC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:49:27 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id y26so24182898lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xyolfoRRwbVIP6OuNHHRJxW8c1ckAZHd8CQ+YzCEItg=;
        b=jhFLBPRt5ibdj5m8MjHnIYzqg3/agjnuyKJbKNotFOa3kgQMmBIWikHAohvgIuQQG2
         ILK/PL5g4wB4PCrUzFfp8WDYBJ1tzmLR5CyIalREs8kGWXr1MCjrjRsSjvRd8vlCZq75
         oNZQJblrPoaHyzI5xJacGD5vCJfE8vtHjKRGEvEoJ2fjfXZYqmKjpKXrPd/ZW/hZrgPx
         RjtLKMShoVGKLP+mzbfzBrFJ8+OSVYPqrzJHCRT2CCgJES6gx9wPx3CcJG29zs/gIH9W
         Wu/tPjPGgptlH+KI8eORsXpyiKorYjXr0ppS3tk0E/z/i+5MiS6/IKb5ZdgSVTz4ZMOB
         UTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xyolfoRRwbVIP6OuNHHRJxW8c1ckAZHd8CQ+YzCEItg=;
        b=gn2L2z0a52SqN2kdrDy+JLGUwfvwPu4YPi8NnYXZudRW1CmnqWEkw//2+BWCiDVMCI
         +VjAp7EffPhVIYXlYQureSBil9EWIK/ozAfv2UJUDTXb2wxbSKvjoMds5WZnax5Sbj4P
         xnCDXWS/MFmzI25Jb+kpeTxfKxH6eUeCi/lg9MKjfJhm+X5iJFfhRT2uXqXU7VkUDMsw
         rhEmJmXrvZHr4FQJwxOUbiT5F+jc78U1VpwWURkPbCplBSXsqCMpoZ0+Fqd8gI+oWAW7
         yrkAGsyTcOAudjCyu3b7U3bETgVFF0RlJQLf/9QsjstuGiUBFMNXYsqC5NVynkrC91SM
         DBvw==
X-Gm-Message-State: AOAM531MdpY2ANGm/oLBMWuyrbr0lDOtCkMgJplS0VvTIrokdCVMgoMs
        tgldWUrdEllAdLiIrAT7Uzd2Q9vj/ckJ/6OVels0OA==
X-Google-Smtp-Source: ABdhPJxqNatXEIk4Aax3z6nQtkoc4fqJtcgge+AsAtCbj7G5bmdaZRuwnAm55ya1wyLljmOIkKfHNIxLIHEG0xzMBJY=
X-Received: by 2002:a05:6512:6d1:: with SMTP id u17mr15378156lff.402.1636739365739;
 Fri, 12 Nov 2021 09:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20211102142331.3753798-1-pgonda@google.com> <20211102142331.3753798-5-pgonda@google.com>
 <YYquDWbkIwCkixxD@google.com> <CAMkAt6rHdsdD-L4PbZL7qaOY7GRHmApVJam0V0yY2BnYdhmPjA@mail.gmail.com>
 <YYrZXRTukz3RccPN@google.com> <CAMkAt6qauoiTBXF9VXRGiqtJD5pTAV=NqKHZgNFXHCkrR50gkg@mail.gmail.com>
 <eff7a2cb-f78a-646a-dc0c-b24998e9e9af@amd.com> <CAMkAt6rj94Mzb6HBaqQbi7HHfhS4q1O4fxO8M7Xe=TZeZ0zZOg@mail.gmail.com>
 <CAMkAt6r5MJq0rGYg7MAqm83Xp4mBADSKtQxV=i2_OFuQnDd5Yg@mail.gmail.com> <CAA03e5GDo3oFe8D8xTP1YsasN=moYqnT-AKayu006u1ARa7cYg@mail.gmail.com>
In-Reply-To: <CAA03e5GDo3oFe8D8xTP1YsasN=moYqnT-AKayu006u1ARa7cYg@mail.gmail.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 12 Nov 2021 10:49:14 -0700
Message-ID: <CAMkAt6og+9LJn84PJhhCn9QAkxzAg_27i1iCy+8edLtymUeyaw@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] crypto: ccp - Add SEV_INIT_EX support
To:     Marc Orr <marcorr@google.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas.Lendacky@amd.com, David Rientjes <rientjes@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 10:46 AM Marc Orr <marcorr@google.com> wrote:
>
> On Fri, Nov 12, 2021 at 8:55 AM Peter Gonda <pgonda@google.com> wrote:
> >
> > On Wed, Nov 10, 2021 at 8:32 AM Peter Gonda <pgonda@google.com> wrote:
> > >
> > > On Tue, Nov 9, 2021 at 3:20 PM Brijesh Singh <brijesh.singh@amd.com> wrote:
> > > >
> > > >
> > > >
> > > > On 11/9/21 2:46 PM, Peter Gonda wrote:
> > > > > On Tue, Nov 9, 2021 at 1:26 PM Sean Christopherson <seanjc@google.com> wrote:
> > > > >>
> > > > >> On Tue, Nov 09, 2021, Peter Gonda wrote:
> > > > >>> On Tue, Nov 9, 2021 at 10:21 AM Sean Christopherson <seanjc@google.com> wrote:
> > > > >>>> There's no need for this to be a function pointer, and the duplicate code can be
> > > > >>>> consolidated.
> > > > >>>>
> > > > >>>> static int sev_do_init_locked(int cmd, void *data, int *error)
> > > > >>>> {
> > > > >>>>          if (sev_es_tmr) {
> > > > >>>>                  /*
> > > > >>>>                   * Do not include the encryption mask on the physical
> > > > >>>>                   * address of the TMR (firmware should clear it anyway).
> > > > >>>>                   */
> > > > >>>>                  data.flags |= SEV_INIT_FLAGS_SEV_ES;
> > > > >>>>                  data.tmr_address = __pa(sev_es_tmr);
> > > > >>>>                  data.tmr_len = SEV_ES_TMR_SIZE;
> > > > >>>>          }
> > > > >>>>          return __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
> > > > >>>> }
> > > > >>>>
> > > > >>>> static int __sev_init_locked(int *error)
> > > > >>>> {
> > > > >>>>          struct sev_data_init data;
> > > > >>>>
> > > > >>>>          memset(&data, 0, sizeof(data));
> > > > >>>>          return sev_do_init_locked(cmd, &data, error);
> > > > >>>> }
> > > > >>>>
> > > > >>>> static int __sev_init_ex_locked(int *error)
> > > > >>>> {
> > > > >>>>          struct sev_data_init_ex data;
> > > > >>>>
> > > > >>>>          memset(&data, 0, sizeof(data));
> > > > >>>>          data.length = sizeof(data);
> > > > >>>>          data.nv_address = __psp_pa(sev_init_ex_nv_address);
> > > > >>>>          data.nv_len = NV_LENGTH;
> > > > >>>>          return sev_do_init_locked(SEV_CMD_INIT_EX, &data, error);
> > > > >>>> }
> > > > >>>
> > > > >>> I am missing how this removes the duplication of the retry code,
> > > > >>> parameter checking, and other error checking code.. With what you have
> > > > >>> typed out I would assume I still need to function pointer between
> > > > >>> __sev_init_ex_locked and __sev_init_locked. Can you please elaborate
> > > > >>> here?
> > > > >>
> > > > >> Hmm.  Ah, I got distracted between the original thought, the realization that
> > > > >> the two commands used different structs, and typing up the above.
> > > > >>
> > > > >>> Also is there some reason the function pointer is not acceptable?
> > > > >>
> > > > >> It's not unacceptable, it would just be nice to avoid, assuming the alternative
> > > > >> is cleaner.  But I don't think any alternative is cleaner, since as you pointed
> > > > >> out the above is a half-baked thought.
> > > > >
> > > > > OK I'll leave as is.
> > > > >
> > > > >>
> > > > >>>>> +     rc = init_function(error);
> > > > >>>>>        if (rc && *error == SEV_RET_SECURE_DATA_INVALID) {
> > > > >>>>>                /*
> > > > >>>>>                 * INIT command returned an integrity check failure
> > > > >>>>> @@ -286,8 +423,8 @@ static int __sev_platform_init_locked(int *error)
> > > > >>>>>                 * failed and persistent state has been erased.
> > > > >>>>>                 * Retrying INIT command here should succeed.
> > > > >>>>>                 */
> > > > >>>>> -             dev_dbg(sev->dev, "SEV: retrying INIT command");
> > > > >>>>> -             rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
> > > > >>>>> +             dev_notice(sev->dev, "SEV: retrying INIT command");
> > > > >>>>> +             rc = init_function(error);
> > > > >>>>
> > > > >>>> The above comment says "persistent state has been erased", but __sev_do_cmd_locked()
> > > > >>>> only writes back to the file if a relevant command was successful, which means
> > > > >>>> that rereading the userspace file in __sev_init_ex_locked() will retry INIT_EX
> > > > >>>> with the same garbage data.
> > > > >>>
> > > > >>> Ack my mistake, that comment is stale. I will update it so its correct
> > > > >>> for the INIT and INIT_EX flows.
> > > > >>>>
> > > > >>>> IMO, the behavior should be to read the file on load and then use the kernel buffer
> > > > >>>> without ever reloading (unless this is built as a module and is unloaded and reloaded).
> > > > >>>> The writeback then becomes opportunistic in the sense that if it fails for some reason,
> > > > >>>> the kernel's internal state isn't blasted away.
> > > > >>>
> > > > >>> One issue here is that the file read can fail on load so we use the
> > > > >>> late retry to guarantee we can read the file.
> > > > >>
> > > > >> But why continue loading if reading the file fails on load?
> > > > >>
> > > > >>> The other point seems like preference. Users may wish to shutdown the PSP FW,
> > > > >>> load a new file, and INIT_EX again with that new data. Why should we preclude
> > > > >>> them from that functionality?
> > > > >>
> > > > >> I don't think we should preclude that functionality, but it needs to be explicitly
> > > > >> tied to a userspace action, e.g. either on module load or on writing the param to
> > > > >> change the path.  If the latter is allowed, then it needs to be denied if the PSP
> > > > >> is initialized, otherwise the kernel will be in a non-coherent state and AFAICT
> > > > >> userspace will have a heck of a time even understanding what state has been used
> > > > >> to initialize the PSP.
> > > > >
> > > > > If this driver is builtin the filesystem will be unavailable during
> > > > > __init. Using the existing retries already built into
> > > > > sev_platform_init() also the file to be read once userspace is
> > > > > running, meaning the file system is usable. As I tried to explain in
> > > > > the commit message. We could remove the sev_platform_init call during
> > > > > sev_pci_init since this only actually needs to be initialized when the
> > > > > first command requiring it is issues (either reading some keys/certs
> > > > > from the PSP or launching an SEV guest). Then userspace in both the
> > > > > builtin and module usage would know running one of those commands
> > > > > cause the file to be read for PSP usage. Tom any thoughts on this?
> > > > >
> > > >
> > > > One thing to note is that if we do the INIT on the first command then
> > > > the first guest launch will take a longer. The init command is not
> > > > cheap (especially with the SNP, it may take a longer because it has to
> > > > do all those RMP setup etc). IIRC, in my early SEV series in I was doing
> > > > the INIT during the first command execution and based on the
> > > > recommendation moved to do the init on probe.
> > > >
> > > > Should we add a module param to control whether to do INIT on probe or
> > > > delay until the first command ?
> > >
> > > Thats a good point Brijesh. I've only been testing this with SEV and
> > > ES so haven't noticed that long setup time. I like the idea of a
> > > module parameter to decide when to INIT, that should satisfy Sean's
> > > concern that the user doesn't know when the INIT_EX file would be read
> > > and that there is extra retry code (duplicated between sev_pci_init
> > > and all the PSP commands). I'll get started on that.
> >
> > I need a little guidance on how to proceed with this. Should I have
> > the new module parameter 'psp_init_on_probe' just disable PSP init on
> > module init if false. Or should it also disable PSP init during
> > command flow if it's true?
> >
> > I was thinking I should just have 'psp_init_on_probe' default to true,
> > and if false it stops the PSP init during sev_pci_init(). If I add the
> > second change that seems like it changes the ABI. Thoughts?
>
> What about doing the INIT when we load the KVM module? Does that
> resolve all of these problems? By the time we load the KVM module, we
> know that the file system is up, which is the original problem we were
> trying to solve. And the KVM module is most likely loaded before we
> run the first guest.

KVM can be compiled as Y as well right? Then KVM module init is still too early.
