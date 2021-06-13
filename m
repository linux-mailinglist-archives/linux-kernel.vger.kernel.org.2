Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521D43A57B7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 12:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhFMKgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 06:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhFMKgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 06:36:21 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CC5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 03:34:21 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j184so35708195qkd.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 03:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ItIPBAIHEXbe1Lun0dGrCgGkZ4iW53VwGWvUtNP7+Uo=;
        b=rD8rpMYCE2NqgjqMkZkF+MfSZNzmA+q34Ul2rRvP/QNS8tM3u/HfOPDxn/624uFjzm
         8AaQT5d6JOH0RAYErLjQyrCGXwAYshNBnQshoKs3yZ8uUu8/5tWfzHu63CsT6fdkrFy4
         w8Q2q+De6hGzdWXowkAWTyBGbGCLiL6lVKIw1QESKkTllJ/rM8AJkbw3PRrRr+Fg2z7z
         0B+Wn1JiEmguP8lI+i/fMWHq983KMC4y2m9AnWMrg33OOrwgjHlkpNE9l210hsXL94kb
         UyerKS/mHS6iKZW+HRyo94F3IQQlBgKl8rsLYoM/vBtV5ro5+YUBDaIAGcXSzdV0oplF
         Rkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ItIPBAIHEXbe1Lun0dGrCgGkZ4iW53VwGWvUtNP7+Uo=;
        b=ejF6/THjVn3y/WRSY8Yj0vTHOG9gKC8K55paTsWoy+/Rqb/+2Dx5+dKCyErGD+aqcM
         /sAaFwKom58zpkbgU/VIwj+/8fUusOvQGzAx+e1HsZuV4VkqtZFq032Zx6eioKMkxdhm
         petVahbJVtOyT+sEGi2romWkC3P2ahJzW9eba/ygo6P57BJp8hWpnXum4JNnQCDdYgLU
         y6Ne4WkLrs+qAyT9oKjhivY3fdZJUH0GxICzBclHM6+MrqZj8w9kW8zmu/IErvu/gmxy
         D70jDBHiCDM5b037G1hNafCfXbc+DbBiRmf7AYxBrBmE72xXHTtOtWEtS4ghVopHDqr0
         RPDA==
X-Gm-Message-State: AOAM531JB3GtJ//X1qJPkcWs/wmW2T6lp6FO8jfMYGesrY0jpymt9IQb
        Br1WrGvYpBhIXHFNxsskxvs9cXAF5g7bfg==
X-Google-Smtp-Source: ABdhPJzIXOa7OXxpXfg61yv8MQOuQPVNrei3M6NJnxus0XACZGOpTmZLIHdr15aVW4Sb6m8FzCfwpA==
X-Received: by 2002:a37:f510:: with SMTP id l16mr11491706qkk.205.1623580459351;
        Sun, 13 Jun 2021 03:34:19 -0700 (PDT)
Received: from ArchLinux ([191.96.227.140])
        by smtp.gmail.com with ESMTPSA id z136sm8190708qkb.34.2021.06.13.03.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 03:34:18 -0700 (PDT)
Date:   Sun, 13 Jun 2021 16:04:04 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Amit Choudhary <amitchoudhary0523@gmail.com>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: [Code] Fastest String Search Algorithm.
Message-ID: <YMXfHIRojUomB+yx@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Amit Choudhary <amitchoudhary0523@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
References: <CAFf+5zhSH_dJ2Zc5EcfqgTew8w0sEu4hLjKYf3fTmqB5mdgfwQ@mail.gmail.com>
 <YMXYYgR82VZISjtO@ArchLinux>
 <CAFf+5zjn9K-ufRGLQdH9B1OrMEzQdP2M-xPkbuss9Uq0c82Z5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YsEPcNjTTMqyY4ap"
Content-Disposition: inline
In-Reply-To: <CAFf+5zjn9K-ufRGLQdH9B1OrMEzQdP2M-xPkbuss9Uq0c82Z5w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YsEPcNjTTMqyY4ap
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15:47 Sun 13 Jun 2021, Amit Choudhary wrote:

Woohooo , kiddo.... you told me where exactly you came from.

  You are now ignored....blocked ...feel really sorry for you.



>   Bhaskar,
>   Fuck you.
>   You are not the owner of linux kernel.
>   You are a very big idiot.
>   You really don't know who you are talking to.
>   You are just assuming that I am a stupid guy without knowing anything
>   about me.
>   My linux kernel patches are in linux kernel since 2005-2006.
>   What are your educational and professional qualifications?
>   I don't think you are from IIT like me, probably you are from a third
>   grade donation based college.
>   I have invented a new search engine architecture and implemented it and
>   it is hosted on sourceforge.
>   Have you ever invented anything?
>   World is full of idiots like you from India who think that they are
>   supreme and everyone else is a fool.
>   Amit
>   On Sun, Jun 13, 2021, 3:35 PM Bhaskar Chowdhury
>   <[1]unixbhaskar@gmail.com> wrote:
>
>     On 14:00 Sun 13 Jun 2021, Amit Choudhary wrote:
>     Ahhhhhhhh...
>     Oh crap! Get off the lawn , kiddo. Do NOT USE THIS PLACE for your
>     obnoxious
>     desire.
>     We don't have time and energy to evaluate some airy-fairy stuff .
>     How do you know we will ever bother to think about "include your
>     code"?? Let
>     alone other factor...huh...you are living in fool's paradise
>     ...meh... look
>     like your head is filled with lots of preconceived dogma....where
>     have you got
>     those?? Heck..
>     Your intention is not wise...this mailing list solely exist for
>     people
>     interested in Linux and only in Linux Kernel. Period.
>     IOW , PLEASE DO NOT BOTHER US.
>     ~Bhaskar
>     >Hi All,
>     >
>     >I have invented a new string search algorithm. It has performed
>     better
>     >than strstr(), Boyer-Moore, and KPM algorithms.
>     >
>     >But I am not sending my code so that my algorithm gets included in
>     linux kernel.
>     >
>     >I am sending this code because linux kernel mailing list is in
>     public
>     >domain and getting indexed by search engines. So, people can see
>     this
>     >algo if they search for fastest string search algorithm on web.
>     >
>     >Code:
>     >
>     >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     >
>     >// Choudhary string search algorithm
>     >static char * choudhary_string_search_algorithm(char *text, char
>     *pattern)
>     >{
>     >
>     >#define false 0
>     >#define true 1
>     >#define ALPHABET_SIZE 256
>     >
>     >=C2  =C2  int i =3D 0;
>     >=C2  =C2  int end_index =3D 0;
>     >=C2  =C2  int not_found =3D false;
>     >
>     >=C2  =C2  char pattern_char[ALPHABET_SIZE] =3D {0};
>     >
>     >=C2  =C2  int text_len =3D strlen(text);
>     >=C2  =C2  int pattern_len =3D strlen(pattern);
>     >
>     >=C2  =C2  int pi_44 =3D pattern_len - 1;
>     >=C2  =C2  int pi_34 =3D (3 * pattern_len) / 4;
>     >=C2  =C2  int pi_24 =3D pattern_len / 2;
>     >=C2  =C2  int pi_14 =3D pattern_len / 4;
>     >
>     >=C2  =C2  int last_failed_index =3D -1;
>     >
>     >=C2  =C2  // preprocessing
>     >=C2  =C2  for (i =3D 0; i < pattern_len; i++) {
>     >=C2  =C2  =C2  =C2  pattern_char[(int)(pattern[i])] =3D 1;
>     >=C2  =C2  }
>     >
>     >=C2  =C2  // now search
>     >=C2  =C2  for (i =3D 0; i < text_len; i++) {
>     >
>     >=C2  =C2  =C2  =C2  if ((text_len - i) < pattern_len) {
>     >=C2  =C2  =C2  =C2  =C2  =C2  return NULL;
>     >=C2  =C2  =C2  =C2  =C2  =C2  //return -1;
>     >=C2  =C2  =C2  =C2  }
>     >
>     >=C2  =C2  =C2  =C2  if (pattern[pi_44] !=3D text[i + pi_44]) {
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  last_failed_index =3D pi_44;
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  // this character doesn't appear in pa=
ttern, so
>     skip
>     >=C2  =C2  =C2  =C2  =C2  =C2  if (pattern_char[(int)(text[i + pi_44]=
)] =3D=3D 0) {
>     >=C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  i =3D i + pi_44;
>     >=C2  =C2  =C2  =C2  =C2  =C2  }
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  continue;
>     >
>     >=C2  =C2  =C2  =C2  } else if (pattern[pi_34] !=3D text[i + pi_34]) {
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  last_failed_index =3D pi_34;
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  // this character doesn't appear in pa=
ttern, so
>     skip
>     >=C2  =C2  =C2  =C2  =C2  =C2  if (pattern_char[(int)(text[i + pi_34]=
)] =3D=3D 0) {
>     >=C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  i =3D i + pi_34;
>     >=C2  =C2  =C2  =C2  =C2  =C2  }
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  continue;
>     >
>     >=C2  =C2  =C2  =C2  } else if (pattern[pi_24] !=3D text[i + pi_24]) {
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  last_failed_index =3D pi_24;
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  // this character doesn't appear in pa=
ttern, so
>     skip
>     >=C2  =C2  =C2  =C2  =C2  =C2  if (pattern_char[(int)(text[i + pi_24]=
)] =3D=3D 0) {
>     >=C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  i =3D i + pi_24;
>     >=C2  =C2  =C2  =C2  =C2  =C2  }
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  continue;
>     >
>     >=C2  =C2  =C2  =C2  } else if (pattern[pi_14] !=3D text[i + pi_14]) {
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  last_failed_index =3D pi_14;
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  // this character doesn't appear in pa=
ttern, so
>     skip
>     >=C2  =C2  =C2  =C2  =C2  =C2  if (pattern_char[(int)(text[i + pi_14]=
)] =3D=3D 0) {
>     >=C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  i =3D i + pi_14;
>     >=C2  =C2  =C2  =C2  =C2  =C2  }
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  continue;
>     >
>     >=C2  =C2  =C2  =C2  } // end of if-else.. block
>     >
>     >=C2  =C2  =C2  =C2  // compare with character at last failed index.
>     >=C2  =C2  =C2  =C2  if (last_failed_index >=3D 0) {
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  if (pattern[last_failed_index] !=3D te=
xt[i +
>     last_failed_index]) {
>     >=C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  continue;
>     >=C2  =C2  =C2  =C2  =C2  =C2  }
>     >
>     >=C2  =C2  =C2  =C2  }
>     >
>     >=C2  =C2  =C2  =C2  if (pattern[0] =3D=3D text[i]) {
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  //full_pattern_search =3D full_pattern=
_search + 1;
>     >=C2  =C2  =C2  =C2  =C2  =C2  end_index =3D i + pi_44;
>     >=C2  =C2  =C2  =C2  =C2  =C2  not_found =3D false;
>     >=C2  =C2  =C2  =C2  =C2  =C2  int index =3D 0;
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  for (index =3D i; index <=3D end_index=
; index++) {
>     >=C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  if (text[index] !=3D pattern=
[index - i]) {
>     >=C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  last_failed_index =
=3D index - i;
>     >=C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  not_found =3D true;
>     >=C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  break;
>     >=C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  }
>     >=C2  =C2  =C2  =C2  =C2  =C2  } // end of inner for loop
>     >
>     >=C2  =C2  =C2  =C2  =C2  =C2  if (not_found =3D=3D false) { // match=
 is found
>     >=C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  return (text + i);
>     >=C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  //return i;
>     >=C2  =C2  =C2  =C2  =C2  =C2  } else if (pattern_char[(int)(text[ind=
ex])] =3D=3D 0)
>     {
>     >=C2  =C2  =C2  =C2  =C2  =C2  =C2  =C2  i =3D index;
>     >=C2  =C2  =C2  =C2  =C2  =C2  }
>     >=C2  =C2  =C2  =C2  } // end of if pattern[0]
>     >
>     >=C2  =C2  } // end of outer for loop
>     >
>     >=C2  =C2  return NULL;
>     >=C2  =C2  //return -1;
>     >
>     >} // end of choudhary_string_search_algorithm
>     >
>     >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     >
>     >Regards,
>     >Amit
>
>References
>
>   1. mailto:unixbhaskar@gmail.com

--YsEPcNjTTMqyY4ap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmDF3xkACgkQsjqdtxFL
KRWkqAf/QWhwfQWQSEVlZdjIw7sb82hbd7ZFTqeaCoFe+V2nZhN2bNXpO1m1c9qY
/xd/fCK+OQGDmuAK340JxnXJSnBps9rXdvwYp1yBICfuaa6VjtdDN2IvPI1QQqLj
Lc0yrKOrTfx6F6h/HoTbxwUe/yrvzzeKxg97y7yhuwBtv0ECl8WT2b8GTWn624M4
v+hdu7Mt3oB1DRGQCyyxgeTIJUEimpyVenrdar0+ps6Fc1cuH0s5us4M0bhuOnGp
UbujnQVq2/6qpdZkCQ8Ex4AQnPF4zA8yHpDBcCuD5FFh49RLHQ8IoJmVz8+2EnbR
q6PZdDGyNqZKz4thB8VoUCHjcZn44g==
=d6S2
-----END PGP SIGNATURE-----

--YsEPcNjTTMqyY4ap--
