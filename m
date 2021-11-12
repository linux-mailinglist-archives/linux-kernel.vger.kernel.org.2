Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0687644E481
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhKLKZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhKLKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:25:34 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EBAC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:22:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p16so21176119lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=Nv76+KxUwQSjfajjsOvmzhY4vn4SVzAOXqBTvRfvshE=;
        b=G34tr19i2F5Oa4Y/mUEdOf+iG8/uEmbeHaBOBtV+I6+IimiVkqEAy0otwinHuhMwFA
         +Pdxz1w10TNm2H+0Ml4wju96d5SA88ULUG4j8D+zGoZvDfzkbYmF7VMAZDz9nSkffzOZ
         Hxu37IbH07fdZVoIipINhWmcMAkm5nI56DPCmoKa4mWHGLghHacI4j5vGupcLUh3uFsr
         HZzmvu6DC2SVs1MGTsPQ9ruAU5UG5UBvS6ym801x4jEjgMNY4FcOs9FCJ3OWwvR5WURl
         WiSRH1piyRb+XYKSaZfRglPwnYvHtCz++Hdckakakrm5pYVUbRMzDGOvPE/aR83Le5Sl
         oNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=Nv76+KxUwQSjfajjsOvmzhY4vn4SVzAOXqBTvRfvshE=;
        b=avI3U61R6uM5I/ZjSdKZ0EV3MwhnST9zdiIKvHItT111+ZwqaZe5R3TMuqNNMsyD6C
         uSdbhwofkNHTU1T5Qc+M0rB1q7xWINcEmUdKkFjjlJ6yttpDxHGPrZwFiYvOEBemkvZN
         T2ZZz7Oz+WENtNPdyeVy4IEbO9xpBUQVxY+jTGEyr4qIyhbPN8bZLayDTE0+p156s59/
         3/6A/6RWi318+x4PCqkuDmYL86ZmDd2XDVYGeBI4nM+eY/7zHhbvCqC6JNG/PssSMvsY
         iOI9g2G2JSeS0jd/Mga0OoAavcGTu2q4NEyKPCEs56NReFNRyAgOobwbr3csEpSeHUGH
         NeyQ==
X-Gm-Message-State: AOAM533nyecfvy7U4RfM9+u6rtJ1etgB2sKNLHir+qlOB34fNK/m7hlQ
        DbT3wm1mGhZnFw6N8cpdQh4=
X-Google-Smtp-Source: ABdhPJxWzQMLKfktY9Pa8nKyW6VTZimeOi+LN8QrGVGHBHQtktsm4nE7IpsHbnhyX+ytjwswNei4Xw==
X-Received: by 2002:a05:6512:224d:: with SMTP id i13mr759042lfu.432.1636712562319;
        Fri, 12 Nov 2021 02:22:42 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id f23sm586203ljg.90.2021.11.12.02.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 02:22:42 -0800 (PST)
Date:   Fri, 12 Nov 2021 12:22:39 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v4 0/6] Cleanups for the nomodeset kernel command line
 parameter logic
Message-ID: <20211112122239.26b3787c@eldfell>
In-Reply-To: <f215e009-94af-fdb5-9ab9-ec5806a0c526@suse.de>
References: <20211108140648.795268-1-javierm@redhat.com>
        <a8d93a19-c7e6-f651-a1cb-9e2742383c73@suse.de>
        <20211112105641.25a4e1a7@eldfell>
        <CAFOAJEd6wNDF93Z1Y6-62pnRzth9Fg4+56+jqCe2qmHk-adR1w@mail.gmail.com>
        <f215e009-94af-fdb5-9ab9-ec5806a0c526@suse.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//kB3ynSXRnvhWn/4n2G/f4D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//kB3ynSXRnvhWn/4n2G/f4D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Nov 2021 11:09:13 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Hi
>=20
> Am 12.11.21 um 10:39 schrieb Javier Martinez Canillas:
> > Hello Pekka,
> >=20
> > On 11/12/21 09:56, Pekka Paalanen wrote:
> >=20
> > [snip]
> >  =20
> >>
> >> Hi,
> >>
> >> these ideas make sense to me, so FWIW,
> >>
> >> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> >> =20
> >=20
> > Thanks.
> >  =20
> >> There is one nitpick I'd like to ask about:
> >>
> >> +bool drm_get_modeset(void)
> >> +{
> >> +     return !drm_nomodeset;
> >> +}
> >> +EXPORT_SYMBOL(drm_get_modeset);
> >>
> >> Doesn't "get" have a special meaning in the kernel land, like "take a
> >> strong reference on an object and return it"? =20
> >=20
> > That's a very good point.
> >  =20
> >> As this is just returning bool without changing anything, the usual
> >> word to use is "is". Since this function is also used at most once per
> >> driver, which is rarely, it could have a long and descriptive name.
> >>
> >> For example:
> >>
> >> bool drm_is_modeset_driver_allowed(void); =20
>=20
> I'd nominate
>=20
>    bool drm_native_drivers_enabled()
>=20
> This is what HW-specific drivers want to query in their init/probing=20
> code. The actual semantics of this decision is hidden from the driver.=20
> It's also easier to read than the other name IMHO

Ok, but what is a "native driver"? Or a "non-native driver"?
Is that established kernel terminology?

I'd think a non-native driver is something that e.g. ndiswrapper is
loading. Is simpledrm like ndiswrapper in a sense? IIRC, simpledrm is
the driver that would not consult this function, right?


Thanks,
pq

>=20
> Best regards
> Thomas
>=20
> >> =20
> >=20
> > Yeah, naming is hard. Jani also mentioned that he didn't like this
> > function name, so I don't mind to re-spin the series only for that.
> >  =20
> >> - "drm" is the namespace
> >> - "is" implies it is a read-only boolean inspection
> >> - "modeset" is the feature being checked
> >> - "driver" implies it is supposed gate driver loading or
> >>    initialization, rather than modesets after drivers have loaded
> >> - "allowed" says it is asking about general policy rather than what a
> >>    driver does
> >> =20
> >=20
> > I believe that name is more verbose than needed. But don't have a
> > strong opinion and could use it if others agree.
> >  =20
> >> Just a bikeshed, I'll leave it to actual kernel devs to say if this
> >> would be more appropriate or worth it.
> >> =20
> >=20
> > I think is worth it and better to do it now before the patches land, but
> > we could wait for others to chime in.
> >=20
> > Best regards,
> > --
> > Javier Martinez Canillas
> > Linux Engineering
> > Red Hat
> >  =20
>=20


--Sig_//kB3ynSXRnvhWn/4n2G/f4D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmGOQG8ACgkQI1/ltBGq
qqeMGg//a93LXDMEiMBv3ZggQkEIgc2kAtzURBzYCFp3C9l+zC/gY4OCTcUfcS2+
Lo2mshr847Q60aucCg7/mEO3AmlzpVuYP2Dcnflfi+k3GzP9NRJRfTSUSQ8Bc0AJ
sXWjCiCQ2Ikx5xR16FEIwGsSFX9a0ZnjHamIexwZXSFNvzqPE2aTSBwoM8HKnReF
ZcilCsbTIy7nIhPxkqKI0BCE9gWa3qFpHZL4mFZjog/QBYL3pu1rmBWVLWEyLrXa
j/UFmF4caHZibcgTBjX2qSgOgNWz0pTVWhZX2XHY9OsOZwI7aNprp8Dz/W2RoPxh
Lq/YevaTBB3p/IxciZMu0tvhOQtbqzB9AwLnzTWsANLHES0U3ZzHORuJrtbmCyUA
x0ADwZgcECE1WwqFa0YtFZ0nxSjIv+O9ZGO1f9mpGFuOSXHXOPS6kyvCCDAerOqR
gara+15jNKsbGVXTsMbcFDuUg1AN0fXPmg7+D/nM9GPKePXKJcsIS13/IMVjumHO
tdYDJZNAdLuMMjhoA3cdjGaAO1nchzh+OnUoAi3ZSiFX+XnJtkuT/XRjTV7BUA8V
zqqKI9Bt674bJJfrG2phuA0dJ7y/SZzNxA0xUtb3u0FMgrKn0orAk4uXMWxegTfy
/hHyrptGVRDbK5lbWZNBBkuNIDsWBXj5Cl3xfAQOY3N5aa1TLEg=
=FG7s
-----END PGP SIGNATURE-----

--Sig_//kB3ynSXRnvhWn/4n2G/f4D--
