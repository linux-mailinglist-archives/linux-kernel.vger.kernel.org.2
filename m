Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2FD39A2EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhFCOVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:21:53 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:41541 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhFCOVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:21:53 -0400
Received: by mail-ej1-f52.google.com with SMTP id gb17so9481568ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tub/4A1Ldp0doIeEbmBbVu6oAKbNZfp1WJZosekTKkc=;
        b=dscUc9TVcSoBWWqro6OIsaQZfbSfG/rarxHo0R2YaesEtBsR6sO5qXfJqMxz9V4fxE
         rKLW3V8qpJ/7iz+1mCbPxCdja7o0Q/pry5jKcpsOWrpe4jur1aMLyEHsS6XQbxRwq7mr
         3Wz1n1C8HWSMnj0fWjPs1SqLEOC20lunSumVi91aSHL+jBAXk3T3sxijZZGfRB7rn5vj
         IeSe8gKwukDIU1HnSBlqW5MMZ97cZZfA/3ya86xweFe/JrUptlbgjHJYIaVwRxx+lmhH
         Vy9qMjtXu9GaV7K/q+gOz9r6CoUdEmmZrnYP+UnotFYCDamyrvEZMI8udZ4NeMUsEqGq
         xg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tub/4A1Ldp0doIeEbmBbVu6oAKbNZfp1WJZosekTKkc=;
        b=l6DQBjiXw6Ln8UloPSvEl3EET1ajYhmDbe29bQIAO2UXj+nKMTzB7YRD0lbrgW5Y0p
         bXIixV8v0hKmo8+cBGyJcYaqO85NeJSNlt6PmRQ/RJRIsQkpXFesIUxS9+Nwd4ha9U9l
         IbeEE6o75RAtWi0mufQ93TIw9rt60rUMt1uZkUVLfKhJ+bCJAfukAP8P6VW9xF1CHAvY
         n0GxJPvxw+9D8ql/FCJZ8DLzX/JTcwUBsi3Ym4Wc7RfOgYHZLJa3x9YOOet+KpFrkfrH
         AFLGkL3PuzTYZf6RG6AhaWecdaHWPSFfWHgWOTenDlPrCLknrqgFnIRHQxZQzlls87ma
         TySA==
X-Gm-Message-State: AOAM533WGeJYzx0mdPoYEBami6Gqa1i99PbzAaHriGvlLQLzwqIStQ+n
        /EIjt0Aavk4B2IFqsCVEc18=
X-Google-Smtp-Source: ABdhPJwr6Ij8uvak3IHGofE/gdNx7SYiNeWGcYR4EZtxiByBFvJyW/hchMvIenwfXZ8TmkIW6HN8tg==
X-Received: by 2002:a17:906:8318:: with SMTP id j24mr20601777ejx.375.1622729932620;
        Thu, 03 Jun 2021 07:18:52 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id bd3sm1858706edb.34.2021.06.03.07.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 07:18:50 -0700 (PDT)
Date:   Thu, 3 Jun 2021 16:20:27 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Stefan Agner <stefan@agner.ch>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH 2/6] ARM: xen: Register with kernel restart handler
Message-ID: <YLjlKwgKdYZ13RAU@orome.fritz.box>
References: <20191015145147.1106247-1-thierry.reding@gmail.com>
 <20191015145147.1106247-3-thierry.reding@gmail.com>
 <CAF2Aj3hbW7+pNp+_jnMVL8zeSxAvSbV1ZFZ_4PAUj6J0TxMk7g@mail.gmail.com>
 <20210603131124.GA1040254@roeck-us.net>
 <20210603133840.GB2435141@dell>
 <7a1cf301-ba99-1e01-c43e-53b53f4d3e04@oracle.com>
 <20210603135608.GU30436@shell.armlinux.org.uk>
 <20210603140301.GC2435141@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ts8oacsaxkBHlaSj"
Content-Disposition: inline
In-Reply-To: <20210603140301.GC2435141@dell>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ts8oacsaxkBHlaSj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 03, 2021 at 03:03:01PM +0100, Lee Jones wrote:
> On Thu, 03 Jun 2021, Russell King (Oracle) wrote:
>=20
> > On Thu, Jun 03, 2021 at 09:48:59AM -0400, Boris Ostrovsky wrote:
> > > On 6/3/21 9:38 AM, Lee Jones wrote:
> > > > On Thu, 03 Jun 2021, Guenter Roeck wrote:
> > > >
> > > >> On Thu, Jun 03, 2021 at 01:43:36PM +0100, Lee Jones wrote:
> > > >>> On Tue, 15 Oct 2019 at 15:52, Thierry Reding <thierry.reding@gmai=
l.com>
> > > >>> wrote:
> > > >>>
> > > >>>> From: Guenter Roeck <linux@roeck-us.net>
> > > >>>>
> > > >>>> Register with kernel restart handler instead of setting arm_pm_r=
estart
> > > >>>> directly.
> > > >>>>
> > > >>>> Select a high priority of 192 to ensure that default restart han=
dlers
> > > >>>> are replaced if Xen is running.
> > > >>>>
> > > >>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > >>>> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > >>>> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.co=
m>
> > > >>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > >>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > >>>> ---
> > > >>>>  arch/arm/xen/enlighten.c | 12 ++++++++++--
> > > >>>>  1 file changed, 10 insertions(+), 2 deletions(-)
> > > >>>>
> > > >>> This patch does appear to be useful.
> > > >>>
> > > >>> Is this just being solved in downstream trees at the moment?
> > > >>>
> > > >>> It would be nice if we could relinquish people of this burden and=
 get it
> > > >>> into Mainline finally.
> > > >>>
> > > >> There must have been half a dozen attempts to send this patch seri=
es
> > > >> upstream. I have tried, and others have tried. Each attempt failed=
 with
> > > >> someone else objecting for non-technical reasons (such as "we need=
 more
> > > >> reviews") or no reaction at all, and maintainers just don't pick i=
t up.
> > > > Looking at the *-by tag list above, I think we have enough quality
> > > > reviews to take this forward.
> > > >
> > > >> So, yes, this patch series can only be found in downstream trees,
> > > >> and it seems pointless to submit it yet again.
> > > > IMHO, it's unfair to burden multiple downstream trees with this pur=
ely
> > > > due to poor or nervy maintainership.  Functionality as broadly usef=
ul
> > > > as this should be merged and maintained in Mainline.
> > > >
> > > > OOI, who is blocking?  As I see it, we have 2 of the key maintainers
> > > > in the *-by list.  With those on-board, it's difficult to envisage
> > > > what the problem is.
> > >=20
> > >=20
> > > Stefano (who is ARM Xen maintainer) left Citrix a while ago. He is at=
 sstabellini@kernel.org (which I added to the CC line).
> >=20
> > Stefano already reviewed this patch, which is part of a larger series
> > that primarily touches 32-bit ARM code, but also touches 64-bit ARM
> > code as well.
> >=20
> > As I said in my previous reply, I don't see that there's any problem
> > with getting these patches merged had the usual processes been
> > followed - either ending up in the patch system, or the pull request
> > being sent to me directly.
> >=20
> > Sadly, the pull request was sent to the arm-soc people excluding me,
> > I happened to notice it and requested to see the patches that were
> > being asked to be pulled (since I probably couldn't find them)...
> > and it then took two further weeks before the patches were posted,
> > which I then missed amongst all the other email.
> >=20
> > It's a process failure and unfortunate timing rather than anything
> > malicious.
>=20
> Understood.
>=20
> Is there anything I can do to help this forward?
>=20
> I can either collect and re-submit the patches to the MLs if that
> makes people's lives any easier.  Or if one of the original submitters
> wish to retain responsibility, I have no qualms with that either.

I had stumbled across these patches from Guenter when I was looking to
solve a reboot/power-off issue on one of the boards that I was working
on. This was supposed to be preparatory work to get rid of the global
function pointers that drivers are simply overwriting, and the goal had
been to add a "system power" framework that would allow drivers to
register a chip structure to provide a bit more "formality" than
overwriting function pointers or registering notifier callbacks.

There ended up not being any interest in such a subsystem, so I wanted
to at least get this prep work in, because it is at least a bit of an
improvement.

I vaguely recall that Arnd or perhaps Olof had mentioned that they'd
pull these patches, but the timing was bad, so they asked me to remind
them after the merge window. By the time we had gotten through the merge
window, I probably had gotten sidetracked and forgot...

Feel free to give this a shot. This series itself is still useful, in my
opinion.

Thierry

--ts8oacsaxkBHlaSj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC45SkACgkQ3SOs138+
s6ETyA/9HEm2JR4h4HDcPjniQnuX58wQLgyp7ttzgnIxg4j03+GJDk+IsR2AnTtP
xc430zlM3efExiIBqnLCZ+pOmgnLht+YXHQz59JAL9Xt9CUyfDkxJ2zXvJhOLP3d
XJpFso39Eh2tdH1E9aNg7nM7P1ZnPrWLQGxbZLEYW0gopY+3NPfO+Zq1oC9lUilx
xt30nlN2iK9tiJYgEX2fmIV68DvY8zY+P8i5DYEj4Vq/3R2ssAqviR8WIf6qgqYW
2mQrnYECdmWnFORqTd0Qqx0q64rpC6LxYxJha9yZBvcl0xQaM0JPl8qcm/vQWiFq
93czgnQ4RUPb4Eiz7xbyr9IJlX6suM0VnBzzkAg+lFugIoQbMOfHLzTav8VWk2an
9AAspFsjLHMOoaU7FYRmCtoZFqheq6iZbplpZMx42J4iQhAazJtG8IiOVkAjUAzq
c2umgTeYOuu/28UhBg4oCsVucnMAxh2WWYShCDnHImPLSg9zHHEQamfc1YYNgi5z
RMLpVYXJ2gnft1byQJX1sHYpjH4dWtYUONG7HDittpG/98UIaOjQ7UciIKWra5F9
jWZ2bK/At3bweCYfgnB6rhfINM5Hb2HljgbVZSXQlozhtosuhrHP4r/IhkbEPCJh
o7/9HNattJzPPk2rL5I16ljQjJYbDsw45Z+vXdVgqNegEUEAfBY=
=gyeu
-----END PGP SIGNATURE-----

--ts8oacsaxkBHlaSj--
