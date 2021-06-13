Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46B93A57CC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 12:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhFMLBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 07:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhFMLBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 07:01:01 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959D8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 03:58:59 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c138so22884500qkg.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 03:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lgXCi0/IR/2h3bZ+VY5M2yKwaSx10xwq87QPOkuxp/o=;
        b=bQMocH30uwbqFgzA18W2djHnzThfUAns2wiT/suUlpxvp16bIFmsmkQKgOnjjGPlFq
         K3k2dmrrOos4sS4+lDlzBxTiG7VaVedbgmReUC6hvF0wUPAbwXkaKlPTIz7WUzA3mDjC
         8O7mLCUWfQLZRm2Ip0QAOcWa4Ie/9Nu6Q2I6mTKCYm5vDtMVMFrX+gOzk/BKz3OqOK3e
         jaFvQXCTrzdjFrc3uvXROayKSRcpmEUkMGr4/MFbKinM9xBr3YZyEFwY1WPYhXbVSOhd
         xECnGfmwVMPZbbR+aeTEC7eDTuB1lh3tCKJfQQmii4AcdHB4B+jhoqun2pm/Ej/lfQtq
         TZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lgXCi0/IR/2h3bZ+VY5M2yKwaSx10xwq87QPOkuxp/o=;
        b=A0AQKHQJa8sFKhXNtDzXs6y9f4jt6Oi8kHLdjnpL6VOp9Au/bvWxN63OyHzx83MV76
         Y5d3sH2xKN7D1ft5lA3h/7eZofqPcFFllQ8ZA6xUCuLklQi9sW9jyOAabDhsWqwy6SMW
         vPAsVNGqJM8C5L7qs1saJsiTE0+Rj0vGYfiwU+tzfN7P6eI56PnLJpYVhgYYUk64MTZ3
         vdbEycU/aIHecta0XszTpZ7/50qXO9JVlHNzoKocM/E6mEzTVJ11O73ujlTWgpjKqEF5
         7MMwaYiy0hMu3Er5MwPz/dugeqY54n8yV2tOXpdpRAszm4CsXxKpahnjwBGTbCrFpXJ1
         pUVQ==
X-Gm-Message-State: AOAM533EikJeNFkwuZRw4zpXu1wkh/EXtnkNjv/OUwFVmTSz5KIo2b2H
        SnsFA+QmjzKrnfHPY52T8cdPJarNDTOpSA==
X-Google-Smtp-Source: ABdhPJxFlh4WLtj41hqFAu/uG9oCdurnKUCsNpFSuxZ6W78kvqHbScdEHjV8RNU+bbTecFH+tqW50g==
X-Received: by 2002:a37:e13:: with SMTP id 19mr11540755qko.252.1623581938630;
        Sun, 13 Jun 2021 03:58:58 -0700 (PDT)
Received: from ArchLinux ([191.96.227.140])
        by smtp.gmail.com with ESMTPSA id k8sm7627668qtx.45.2021.06.13.03.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 03:58:57 -0700 (PDT)
Date:   Sun, 13 Jun 2021 16:28:44 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Amit Choudhary <amitchoudhary0523@gmail.com>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: [Code] Fastest String Search Algorithm.
Message-ID: <YMXk5JEpMH2ygdgK@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Amit Choudhary <amitchoudhary0523@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
References: <CAFf+5zhSH_dJ2Zc5EcfqgTew8w0sEu4hLjKYf3fTmqB5mdgfwQ@mail.gmail.com>
 <YMXYYgR82VZISjtO@ArchLinux>
 <CAFf+5zjn9K-ufRGLQdH9B1OrMEzQdP2M-xPkbuss9Uq0c82Z5w@mail.gmail.com>
 <YMXfHIRojUomB+yx@ArchLinux>
 <CAFf+5zgPifhcYSgkg8f_rqPg0NF0B037tqFsOKHNTRqGMJ8udA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="StAigaC4CqF4EMMG"
Content-Disposition: inline
In-Reply-To: <CAFf+5zgPifhcYSgkg8f_rqPg0NF0B037tqFsOKHNTRqGMJ8udA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--StAigaC4CqF4EMMG
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16:16 Sun 13 Jun 2021, Amit Choudhary wrote:

ROFL!!!  Enjoy your victory, kiddo.

>It looks like you are already blocked by many people and maintainers.
>
>Looking at this https://lkml.org/lkml/2021/3/29/1977 , it is clear
>that there are CoC complaints against you.
>
>Amit
>
>
>On Sun, Jun 13, 2021 at 4:04 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> =
wrote:
>>
>> On 15:47 Sun 13 Jun 2021, Amit Choudhary wrote:
>>
>> Woohooo , kiddo.... you told me where exactly you came from.
>>
>>   You are now ignored....blocked ...feel really sorry for you.
>>
>>
>>
>> >   Bhaskar,
>> >   Fuck you.
>> >   You are not the owner of linux kernel.
>> >   You are a very big idiot.
>> >   You really don't know who you are talking to.
>> >   You are just assuming that I am a stupid guy without knowing anything
>> >   about me.
>> >   My linux kernel patches are in linux kernel since 2005-2006.
>> >   What are your educational and professional qualifications?
>> >   I don't think you are from IIT like me, probably you are from a third
>> >   grade donation based college.
>> >   I have invented a new search engine architecture and implemented it =
and
>> >   it is hosted on sourceforge.
>> >   Have you ever invented anything?
>> >   World is full of idiots like you from India who think that they are
>> >   supreme and everyone else is a fool.
>> >   Amit
>> >   On Sun, Jun 13, 2021, 3:35 PM Bhaskar Chowdhury
>> >   <[1]unixbhaskar@gmail.com> wrote:
>> >
>> >     On 14:00 Sun 13 Jun 2021, Amit Choudhary wrote:
>> >     Ahhhhhhhh...
>> >     Oh crap! Get off the lawn , kiddo. Do NOT USE THIS PLACE for your
>> >     obnoxious
>> >     desire.
>> >     We don't have time and energy to evaluate some airy-fairy stuff .
>> >     How do you know we will ever bother to think about "include your
>> >     code"?? Let
>> >     alone other factor...huh...you are living in fool's paradise
>> >     ...meh... look
>> >     like your head is filled with lots of preconceived dogma....where
>> >     have you got
>> >     those?? Heck..
>> >     Your intention is not wise...this mailing list solely exist for
>> >     people
>> >     interested in Linux and only in Linux Kernel. Period.
>> >     IOW , PLEASE DO NOT BOTHER US.
>> >     ~Bhaskar
>> >     >Hi All,
>> >     >
>> >     >I have invented a new string search algorithm. It has performed
>> >     better
>> >     >than strstr(), Boyer-Moore, and KPM algorithms.
>> >     >
>> >     >But I am not sending my code so that my algorithm gets included in
>> >     linux kernel.
>> >     >
>> >     >I am sending this code because linux kernel mailing list is in
>> >     public
>> >     >domain and getting indexed by search engines. So, people can see
>> >     this
>> >     >algo if they search for fastest string search algorithm on web.
>> >     >
>> >     >Code:
>> >     >
>> >     >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >     >
>> >     >// Choudhary string search algorithm
>> >     >static char * choudhary_string_search_algorithm(char *text, char
>> >     *pattern)
>> >     >{
>> >     >
>> >     >#define false 0
>> >     >#define true 1
>> >     >#define ALPHABET_SIZE 256
>> >     >
>> >     >=C3=82  =C3=82  int i =3D 0;
>> >     >=C3=82  =C3=82  int end_index =3D 0;
>> >     >=C3=82  =C3=82  int not_found =3D false;
>> >     >
>> >     >=C3=82  =C3=82  char pattern_char[ALPHABET_SIZE] =3D {0};
>> >     >
>> >     >=C3=82  =C3=82  int text_len =3D strlen(text);
>> >     >=C3=82  =C3=82  int pattern_len =3D strlen(pattern);
>> >     >
>> >     >=C3=82  =C3=82  int pi_44 =3D pattern_len - 1;
>> >     >=C3=82  =C3=82  int pi_34 =3D (3 * pattern_len) / 4;
>> >     >=C3=82  =C3=82  int pi_24 =3D pattern_len / 2;
>> >     >=C3=82  =C3=82  int pi_14 =3D pattern_len / 4;
>> >     >
>> >     >=C3=82  =C3=82  int last_failed_index =3D -1;
>> >     >
>> >     >=C3=82  =C3=82  // preprocessing
>> >     >=C3=82  =C3=82  for (i =3D 0; i < pattern_len; i++) {
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  pattern_char[(int)(pattern[i])] =
=3D 1;
>> >     >=C3=82  =C3=82  }
>> >     >
>> >     >=C3=82  =C3=82  // now search
>> >     >=C3=82  =C3=82  for (i =3D 0; i < text_len; i++) {
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  if ((text_len - i) < pattern_len)=
 {
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  return NULL;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  //return -1;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  }
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  if (pattern[pi_44] !=3D text[i + =
pi_44]) {
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  last_failed_index=
 =3D pi_44;
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  // this character=
 doesn't appear in pattern, so
>> >     skip
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  if (pattern_char[=
(int)(text[i + pi_44])] =3D=3D 0) {
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  i=
 =3D i + pi_44;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  }
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  continue;
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  } else if (pattern[pi_34] !=3D te=
xt[i + pi_34]) {
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  last_failed_index=
 =3D pi_34;
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  // this character=
 doesn't appear in pattern, so
>> >     skip
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  if (pattern_char[=
(int)(text[i + pi_34])] =3D=3D 0) {
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  i=
 =3D i + pi_34;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  }
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  continue;
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  } else if (pattern[pi_24] !=3D te=
xt[i + pi_24]) {
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  last_failed_index=
 =3D pi_24;
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  // this character=
 doesn't appear in pattern, so
>> >     skip
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  if (pattern_char[=
(int)(text[i + pi_24])] =3D=3D 0) {
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  i=
 =3D i + pi_24;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  }
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  continue;
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  } else if (pattern[pi_14] !=3D te=
xt[i + pi_14]) {
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  last_failed_index=
 =3D pi_14;
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  // this character=
 doesn't appear in pattern, so
>> >     skip
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  if (pattern_char[=
(int)(text[i + pi_14])] =3D=3D 0) {
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  i=
 =3D i + pi_14;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  }
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  continue;
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  } // end of if-else.. block
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  // compare with character at last=
 failed index.
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  if (last_failed_index >=3D 0) {
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  if (pattern[last_=
failed_index] !=3D text[i +
>> >     last_failed_index]) {
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  c=
ontinue;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  }
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  }
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  if (pattern[0] =3D=3D text[i]) {
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  //full_pattern_se=
arch =3D full_pattern_search + 1;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  end_index =3D i +=
 pi_44;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  not_found =3D fal=
se;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  int index =3D 0;
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  for (index =3D i;=
 index <=3D end_index; index++) {
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  i=
f (text[index] !=3D pattern[index - i]) {
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =
=C3=82  =C3=82  last_failed_index =3D index - i;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =
=C3=82  =C3=82  not_found =3D true;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =
=C3=82  =C3=82  break;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  }
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  } // end of inner=
 for loop
>> >     >
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  if (not_found =3D=
=3D false) { // match is found
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  r=
eturn (text + i);
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  /=
/return i;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  } else if (patter=
n_char[(int)(text[index])] =3D=3D 0)
>> >     {
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  i=
 =3D index;
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  }
>> >     >=C3=82  =C3=82  =C3=82  =C3=82  } // end of if pattern[0]
>> >     >
>> >     >=C3=82  =C3=82  } // end of outer for loop
>> >     >
>> >     >=C3=82  =C3=82  return NULL;
>> >     >=C3=82  =C3=82  //return -1;
>> >     >
>> >     >} // end of choudhary_string_search_algorithm
>> >     >
>> >     >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >     >
>> >     >Regards,
>> >     >Amit
>> >
>> >References
>> >
>> >   1. mailto:unixbhaskar@gmail.com

--StAigaC4CqF4EMMG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmDF5N8ACgkQsjqdtxFL
KRVEbwgAkNWMAaJHwKvlnXBBLvs/5N3HJ8+tIwOWDNcA0zFVD3QA/dwMowZpa6AU
sNvOkhaQoX+evGF3GtDjTar7Zn4nkTZOSnjmi1YGyqwSHFRfg8KM11hxjbhjNezc
FER8ahWdVpLKM1viHRstRiPYHwZ60dPt2lFASibXaFd63hoO8h4rkfUDog6V4b1u
tCcargY9lHjkKTZgKbUJUHNXeyPeQXlRVxTmkQ8V6KBFpspJegpAPjqz8ElOttZv
L3MDtCc2RH9X8HT3KUP9LsGPe0WiP5j9mX2xZDpVb6txqqMoUMC7SjuvsFcA6G0Z
HlOCK/QbLD5NrFbyR5P1G1xIzenSEg==
=1Ey5
-----END PGP SIGNATURE-----

--StAigaC4CqF4EMMG--
