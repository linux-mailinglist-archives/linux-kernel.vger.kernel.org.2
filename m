Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD01D44EC98
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 19:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhKLSbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 13:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhKLSbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 13:31:05 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF110C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 10:28:14 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id t19so19531789oij.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 10:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HMwNPLBTnhg+gZ7hYIJP6ZsXs0JaDZesh/uMRXZDM5E=;
        b=FV+GtoQM5ZgZHQLFpnLgZLsIsUBpnLQzWPdye3mGIBpoI1AmS+Qrv0X86l6HvnuptR
         nzKLE0aeTDjOmhRmZX2NIRoZI5cequcUXIC+OK039vnUu2RQ+PqfdSCwO5WTWyq6Sd8Z
         /qPCam2i1dFp33VVl7tDMXiqI2Kr1mEIkc9mFP+C9su9uNu8JVf8Ziwq0POt/gB8UQjR
         eO/EfVM/Kg3X7DpVAj8oZMkl2AB+T4g/6EIqn0MDeyhp992Vr5MZRppYZtjyajC8v79W
         rZ9TFvr1m5y3GekLQUPU31p/CKdOOYqKmV8kteqAHWjF4OSAiJ8xpVReYC/hrNuJK8ql
         O+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMwNPLBTnhg+gZ7hYIJP6ZsXs0JaDZesh/uMRXZDM5E=;
        b=GAIm5TX5RA/2L8ThIAlZCUpbX5WhHltIIyJveAbwSTVJNkfwJ1FCDDc54WWaWmPW+K
         HPtZgAs3dAQto4Sfy4r6D3jo9MojPye7UrBSHjNgZRKV/N8SXtOmW5i6elOVOuYaePcm
         aj8OfipHh3fjOr8LOK+l48XvV0HwDhEWOUjVX90S+QuX5e1theUrCIMPymx/kVT1b444
         aYp6ITma0Z1cEm5NLbtycfzI4i7jfdzRgUQE4+qXfdy8UbI0x+Cuk2W25jCjGNbY0pdM
         ObvnnL9SJ+I83eyFJh5Am/4Nk1aWeylA0R6DuT2TMyyIxqEW+70asFdjtB9FH+o/L2z1
         xCzg==
X-Gm-Message-State: AOAM532768GFV/TO+pm5PJGcj9S8AAFkyG7QsZSx9cMg2GqWGH8ye6E2
        db7CzvFg496BFjs04C3mK95L0OxAULPlYNGB1jVuCg==
X-Google-Smtp-Source: ABdhPJzxLSBvFUTzogmSMbV5/M3VUQMGVOcxgqoIsEcXefYe6+Z9VI2bxguiMxeYEBKTGjfUlI20oyL0e4BQafpZyT4=
X-Received: by 2002:aca:2319:: with SMTP id e25mr27966403oie.164.1636741693790;
 Fri, 12 Nov 2021 10:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20211102142331.3753798-1-pgonda@google.com> <20211102142331.3753798-5-pgonda@google.com>
 <YYquDWbkIwCkixxD@google.com> <CAMkAt6rHdsdD-L4PbZL7qaOY7GRHmApVJam0V0yY2BnYdhmPjA@mail.gmail.com>
 <YYrZXRTukz3RccPN@google.com> <CAMkAt6qauoiTBXF9VXRGiqtJD5pTAV=NqKHZgNFXHCkrR50gkg@mail.gmail.com>
 <eff7a2cb-f78a-646a-dc0c-b24998e9e9af@amd.com> <CAMkAt6rj94Mzb6HBaqQbi7HHfhS4q1O4fxO8M7Xe=TZeZ0zZOg@mail.gmail.com>
 <CAMkAt6r5MJq0rGYg7MAqm83Xp4mBADSKtQxV=i2_OFuQnDd5Yg@mail.gmail.com>
 <CAA03e5GDo3oFe8D8xTP1YsasN=moYqnT-AKayu006u1ARa7cYg@mail.gmail.com> <CAMkAt6og+9LJn84PJhhCn9QAkxzAg_27i1iCy+8edLtymUeyaw@mail.gmail.com>
In-Reply-To: <CAMkAt6og+9LJn84PJhhCn9QAkxzAg_27i1iCy+8edLtymUeyaw@mail.gmail.com>
From:   Marc Orr <marcorr@google.com>
Date:   Fri, 12 Nov 2021 10:28:02 -0800
Message-ID: <CAA03e5H5WAqVYQ86azVzYfLsAEYS2M_swy9t3RG+3mVZ9twYXQ@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] crypto: ccp - Add SEV_INIT_EX support
To:     Peter Gonda <pgonda@google.com>
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

On Fri, Nov 12, 2021 at 9:49 AM Peter Gonda <pgonda@google.com> wrote:
>
> On Fri, Nov 12, 2021 at 10:46 AM Marc Orr <marcorr@google.com> wrote:
> >
> > On Fri, Nov 12, 2021 at 8:55 AM Peter Gonda <pgonda@google.com> wrote:
> > >
> > > On Wed, Nov 10, 2021 at 8:32 AM Peter Gonda <pgonda@google.com> wrote:
> > > >
> > > > On Tue, Nov 9, 2021 at 3:20 PM Brijesh Singh <brijesh.singh@amd.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 11/9/21 2:46 PM, Peter Gonda wrote:
> > > > > > On Tue, Nov 9, 2021 at 1:26 PM Sean Christopherson <seanjc@google.com> wrote:
> > > > > >>
> > > > > >> On Tue, Nov 09, 2021, Peter Gonda wrote:
> > > > > >>> On Tue, Nov 9, 2021 at 10:21 AM Sean Christopherson <seanjc@google.com> wrote:
> > > > > >>>> There's no need for this to be a function pointer, and the duplicate code can be
> > > > > >>>> consolidated.
> > > > > >>>>
> > > > > >>>> static int sev_do_init_locked(int cmd, void *data, int *error)
> > > > > >>>> {
> > > > > >>>>          if (sev_es_tmr) {
> > > > > >>>>                  /*
> > > > > >>>>                   * Do not include the encryption mask on the physical
> > > > > >>>>                   * address of the TMR (firmware should clear it anyway).
> > > > > >>>>                   */
> > > > > >>>>                  data.flags |= SEV_INIT_FLAGS_SEV_ES;
> > > > > >>>>                  data.tmr_address = __pa(sev_es_tmr);
> > > > > >>>>                  data.tmr_len = SEV_ES_TMR_SIZE;
> > > > > >>>>          }
> > > > > >>>>          return __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
> > > > > >>>> }
> > > > > >>>>
> > > > > >>>> static int __sev_init_locked(int *error)
> > > > > >>>> {
> > > > > >>>>          struct sev_data_init data;
> > > > > >>>>
> > > > > >>>>          memset(&data, 0, sizeof(data));
> > > > > >>>>          return sev_do_init_locked(cmd, &data, error);
> > > > > >>>> }
> > > > > >>>>
> > > > > >>>> static int __sev_init_ex_locked(int *error)
> > > > > >>>> {
> > > > > >>>>          struct sev_data_init_ex data;
> > > > > >>>>
> > > > > >>>>          memset(&data, 0, sizeof(data));
> > > > > >>>>          data.length = sizeof(data);
> > > > > >>>>          data.nv_address = __psp_pa(sev_init_ex_nv_address);
> > > > > >>>>          data.nv_len = NV_LENGTH;
> > > > > >>>>          return sev_do_init_locked(SEV_CMD_INIT_EX, &data, error);
> > > > > >>>> }
> > > > > >>>
> > > > > >>> I am missing how this removes the duplication of the retry code,
> > > > > >>> parameter checking, and other error checking code.. With what you have
> > > > > >>> typed out I would assume I still need to function pointer between
> > > > > >>> __sev_init_ex_locked and __sev_init_locked. Can you please elaborate
> > > > > >>> here?
> > > > > >>
> > > > > >> Hmm.  Ah, I got distracted between the original thought, the realization that
> > > > > >> the two commands used different structs, and typing up the above.
> > > > > >>
> > > > > >>> Also is there some reason the function pointer is not acceptable?
> > > > > >>
> > > > > >> It's not unacceptable, it would just be nice to avoid, assuming the alternative
> > > > > >> is cleaner.  But I don't think any alternative is cleaner, since as you pointed
> > > > > >> out the above is a half-baked thought.
> > > > > >
> > > > > > OK I'll leave as is.
> > > > > >
> > > > > >>
> > > > > >>>>> +     rc = init_function(error);
> > > > > >>>>>        if (rc && *error == SEV_RET_SECURE_DATA_INVALID) {
> > > > > >>>>>                /*
> > > > > >>>>>                 * INIT command returned an integrity check failure
> > > > > >>>>> @@ -286,8 +423,8 @@ static int __sev_platform_init_locked(int *error)
> > > > > >>>>>                 * failed and persistent state has been erased.
> > > > > >>>>>                 * Retrying INIT command here should succeed.
> > > > > >>>>>                 */
> > > > > >>>>> -             dev_dbg(sev->dev, "SEV: retrying INIT command");
> > > > > >>>>> -             rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
> > > > > >>>>> +             dev_notice(sev->dev, "SEV: retrying INIT command");
> > > > > >>>>> +             rc = init_function(error);
> > > > > >>>>
> > > > > >>>> The above comment says "persistent state has been erased", but __sev_do_cmd_locked()
> > > > > >>>> only writes back to the file if a relevant command was successful, which means
> > > > > >>>> that rereading the userspace file in __sev_init_ex_locked() will retry INIT_EX
> > > > > >>>> with the same garbage data.
> > > > > >>>
> > > > > >>> Ack my mistake, that comment is stale. I will update it so its correct
> > > > > >>> for the INIT and INIT_EX flows.
> > > > > >>>>
> > > > > >>>> IMO, the behavior should be to read the file on load and then use the kernel buffer
> > > > > >>>> without ever reloading (unless this is built as a module and is unloaded and reloaded).
> > > > > >>>> The writeback then becomes opportunistic in the sense that if it fails for some reason,
> > > > > >>>> the kernel's internal state isn't blasted away.
> > > > > >>>
> > > > > >>> One issue here is that the file read can fail on load so we use the
> > > > > >>> late retry to guarantee we can read the file.
> > > > > >>
> > > > > >> But why continue loading if reading the file fails on load?
> > > > > >>
> > > > > >>> The other point seems like preference. Users may wish to shutdown the PSP FW,
> > > > > >>> load a new file, and INIT_EX again with that new data. Why should we preclude
> > > > > >>> them from that functionality?
> > > > > >>
> > > > > >> I don't think we should preclude that functionality, but it needs to be explicitly
> > > > > >> tied to a userspace action, e.g. either on module load or on writing the param to
> > > > > >> change the path.  If the latter is allowed, then it needs to be denied if the PSP
> > > > > >> is initialized, otherwise the kernel will be in a non-coherent state and AFAICT
> > > > > >> userspace will have a heck of a time even understanding what state has been used
> > > > > >> to initialize the PSP.
> > > > > >
> > > > > > If this driver is builtin the filesystem will be unavailable during
> > > > > > __init. Using the existing retries already built into
> > > > > > sev_platform_init() also the file to be read once userspace is
> > > > > > running, meaning the file system is usable. As I tried to explain in
> > > > > > the commit message. We could remove the sev_platform_init call during
> > > > > > sev_pci_init since this only actually needs to be initialized when the
> > > > > > first command requiring it is issues (either reading some keys/certs
> > > > > > from the PSP or launching an SEV guest). Then userspace in both the
> > > > > > builtin and module usage would know running one of those commands
> > > > > > cause the file to be read for PSP usage. Tom any thoughts on this?
> > > > > >
> > > > >
> > > > > One thing to note is that if we do the INIT on the first command then
> > > > > the first guest launch will take a longer. The init command is not
> > > > > cheap (especially with the SNP, it may take a longer because it has to
> > > > > do all those RMP setup etc). IIRC, in my early SEV series in I was doing
> > > > > the INIT during the first command execution and based on the
> > > > > recommendation moved to do the init on probe.
> > > > >
> > > > > Should we add a module param to control whether to do INIT on probe or
> > > > > delay until the first command ?
> > > >
> > > > Thats a good point Brijesh. I've only been testing this with SEV and
> > > > ES so haven't noticed that long setup time. I like the idea of a
> > > > module parameter to decide when to INIT, that should satisfy Sean's
> > > > concern that the user doesn't know when the INIT_EX file would be read
> > > > and that there is extra retry code (duplicated between sev_pci_init
> > > > and all the PSP commands). I'll get started on that.
> > >
> > > I need a little guidance on how to proceed with this. Should I have
> > > the new module parameter 'psp_init_on_probe' just disable PSP init on
> > > module init if false. Or should it also disable PSP init during
> > > command flow if it's true?
> > >
> > > I was thinking I should just have 'psp_init_on_probe' default to true,
> > > and if false it stops the PSP init during sev_pci_init(). If I add the
> > > second change that seems like it changes the ABI. Thoughts?
> >
> > What about doing the INIT when we load the KVM module? Does that
> > resolve all of these problems? By the time we load the KVM module, we
> > know that the file system is up, which is the original problem we were
> > trying to solve. And the KVM module is most likely loaded before we
> > run the first guest.
>
> KVM can be compiled as Y as well right? Then KVM module init is still too early.

I think even with KVM built in, it's guaranteed to load after the file system:

* KVM is loaded using `module_init()` (e.g., kvm-amd `module_init()` [1]).
* `module_init()` is defined as `__initcall()` [2].
* `__initcall()` is defined as `device_initcall()` [3].
* Finally, looking at [3] and scrolling up a few lines,
`device_init_call()`'s appear to happen after the file system init
calls.

[1] https://elixir.bootlin.com/linux/latest/source/arch/x86/kvm/svm/svm.c#L4673
[2] https://elixir.bootlin.com/linux/latest/source/include/linux/module.h#L88
[3] https://elixir.bootlin.com/linux/latest/source/include/linux/init.h#L296
