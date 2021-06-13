Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B213A57BD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 12:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhFMKtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 06:49:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41893 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhFMKtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 06:49:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id h4so1208046lfu.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 03:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ht91rmt77xnysElciS99USSoFkQmZzCB1pkzHQ5IYvQ=;
        b=kOjhq0L7wZ4Mm59HTZ8qqVAS0Fzg0hdLjXWxSm5FMe378AwF9zASgojbv87r6wy57Y
         PVxwmatv/7FE0lAKEeA6XWL2MC6iCRVOT+009KKbWTaoyAInZ0gyMVTIGrOsz0HZEOOa
         FIR2Np8Qn9Wzjh3KGYme297tPiemf9vhkEabK1Z6yi2KcVNHpu7ynv4uI42G80BqfI+x
         gGRZaJWlLbC4EXAf6BYUgE70+oLIB3Vud4lDWkbyiIpJ6g5qQDWcazU/RQ7h5Cg/dcNp
         gJH5FLSp+jan1ShVvGox7HIGj8jkqbDCeBcIByDr24cxbp8E3dwWYFhfno+hgTnTx3Ot
         nTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ht91rmt77xnysElciS99USSoFkQmZzCB1pkzHQ5IYvQ=;
        b=VBeIHmbjW6pVbvohC0+zFEKPjIdtO9phhjGhpcT+kPkENBFmc3q7cbPYGIn6SA7hPW
         o3ed0uLlRUVHT6slhxt8WW7XOw/qc5R+lIJxVK2yx96n+q0Ru1+xU7sAcvtyjrgnkg2+
         k+4hQOLHCtpfgnYxm3tJcgy2xvwPRLT15yDycKh/PgW+IQxbLl5ohk4x9x3U9QNBXPPN
         ougX6kTkqHigQ/HM9DZKBiyAqw/4E4k1GgQekuVbh3/ert7ADVB6Y0LDinMs2s704Khd
         gPsyB1IvKZ6hxV5Pc8IalrMELuAwtUv4d89Ps+s9KkWeJ22CzbcD2iR1q99B9n+6/QF/
         fknw==
X-Gm-Message-State: AOAM532lCa8sFCMFKTl/vMJ54KNmvG7sOrKzJgCakug0cAcssi2jcvng
        WKwyrenjNjZJmXqf7df0IDpSrwm4Ok4ELF8aKic=
X-Google-Smtp-Source: ABdhPJx0GN2/anh7tjdmpqYPHFuIghPdKdiVZPf5U5r713DFCOcMNWgGK6oY13vMjPyEzvVVPshR4Tob+PZ/O/kk/to=
X-Received: by 2002:a05:6512:2105:: with SMTP id q5mr8217640lfr.649.1623581202412;
 Sun, 13 Jun 2021 03:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAFf+5zhSH_dJ2Zc5EcfqgTew8w0sEu4hLjKYf3fTmqB5mdgfwQ@mail.gmail.com>
 <YMXYYgR82VZISjtO@ArchLinux> <CAFf+5zjn9K-ufRGLQdH9B1OrMEzQdP2M-xPkbuss9Uq0c82Z5w@mail.gmail.com>
 <YMXfHIRojUomB+yx@ArchLinux>
In-Reply-To: <YMXfHIRojUomB+yx@ArchLinux>
From:   Amit Choudhary <amitchoudhary0523@gmail.com>
Date:   Sun, 13 Jun 2021 16:16:33 +0530
Message-ID: <CAFf+5zgPifhcYSgkg8f_rqPg0NF0B037tqFsOKHNTRqGMJ8udA@mail.gmail.com>
Subject: Re: [Code] Fastest String Search Algorithm.
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Amit Choudhary <amitchoudhary0523@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like you are already blocked by many people and maintainers.

Looking at this https://lkml.org/lkml/2021/3/29/1977 , it is clear
that there are CoC complaints against you.

Amit


On Sun, Jun 13, 2021 at 4:04 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> w=
rote:
>
> On 15:47 Sun 13 Jun 2021, Amit Choudhary wrote:
>
> Woohooo , kiddo.... you told me where exactly you came from.
>
>   You are now ignored....blocked ...feel really sorry for you.
>
>
>
> >   Bhaskar,
> >   Fuck you.
> >   You are not the owner of linux kernel.
> >   You are a very big idiot.
> >   You really don't know who you are talking to.
> >   You are just assuming that I am a stupid guy without knowing anything
> >   about me.
> >   My linux kernel patches are in linux kernel since 2005-2006.
> >   What are your educational and professional qualifications?
> >   I don't think you are from IIT like me, probably you are from a third
> >   grade donation based college.
> >   I have invented a new search engine architecture and implemented it a=
nd
> >   it is hosted on sourceforge.
> >   Have you ever invented anything?
> >   World is full of idiots like you from India who think that they are
> >   supreme and everyone else is a fool.
> >   Amit
> >   On Sun, Jun 13, 2021, 3:35 PM Bhaskar Chowdhury
> >   <[1]unixbhaskar@gmail.com> wrote:
> >
> >     On 14:00 Sun 13 Jun 2021, Amit Choudhary wrote:
> >     Ahhhhhhhh...
> >     Oh crap! Get off the lawn , kiddo. Do NOT USE THIS PLACE for your
> >     obnoxious
> >     desire.
> >     We don't have time and energy to evaluate some airy-fairy stuff .
> >     How do you know we will ever bother to think about "include your
> >     code"?? Let
> >     alone other factor...huh...you are living in fool's paradise
> >     ...meh... look
> >     like your head is filled with lots of preconceived dogma....where
> >     have you got
> >     those?? Heck..
> >     Your intention is not wise...this mailing list solely exist for
> >     people
> >     interested in Linux and only in Linux Kernel. Period.
> >     IOW , PLEASE DO NOT BOTHER US.
> >     ~Bhaskar
> >     >Hi All,
> >     >
> >     >I have invented a new string search algorithm. It has performed
> >     better
> >     >than strstr(), Boyer-Moore, and KPM algorithms.
> >     >
> >     >But I am not sending my code so that my algorithm gets included in
> >     linux kernel.
> >     >
> >     >I am sending this code because linux kernel mailing list is in
> >     public
> >     >domain and getting indexed by search engines. So, people can see
> >     this
> >     >algo if they search for fastest string search algorithm on web.
> >     >
> >     >Code:
> >     >
> >     >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     >
> >     >// Choudhary string search algorithm
> >     >static char * choudhary_string_search_algorithm(char *text, char
> >     *pattern)
> >     >{
> >     >
> >     >#define false 0
> >     >#define true 1
> >     >#define ALPHABET_SIZE 256
> >     >
> >     >=C3=82  =C3=82  int i =3D 0;
> >     >=C3=82  =C3=82  int end_index =3D 0;
> >     >=C3=82  =C3=82  int not_found =3D false;
> >     >
> >     >=C3=82  =C3=82  char pattern_char[ALPHABET_SIZE] =3D {0};
> >     >
> >     >=C3=82  =C3=82  int text_len =3D strlen(text);
> >     >=C3=82  =C3=82  int pattern_len =3D strlen(pattern);
> >     >
> >     >=C3=82  =C3=82  int pi_44 =3D pattern_len - 1;
> >     >=C3=82  =C3=82  int pi_34 =3D (3 * pattern_len) / 4;
> >     >=C3=82  =C3=82  int pi_24 =3D pattern_len / 2;
> >     >=C3=82  =C3=82  int pi_14 =3D pattern_len / 4;
> >     >
> >     >=C3=82  =C3=82  int last_failed_index =3D -1;
> >     >
> >     >=C3=82  =C3=82  // preprocessing
> >     >=C3=82  =C3=82  for (i =3D 0; i < pattern_len; i++) {
> >     >=C3=82  =C3=82  =C3=82  =C3=82  pattern_char[(int)(pattern[i])] =
=3D 1;
> >     >=C3=82  =C3=82  }
> >     >
> >     >=C3=82  =C3=82  // now search
> >     >=C3=82  =C3=82  for (i =3D 0; i < text_len; i++) {
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  if ((text_len - i) < pattern_len) =
{
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  return NULL;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  //return -1;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  }
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  if (pattern[pi_44] !=3D text[i + p=
i_44]) {
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  last_failed_index =
=3D pi_44;
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  // this character =
doesn't appear in pattern, so
> >     skip
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  if (pattern_char[(=
int)(text[i + pi_44])] =3D=3D 0) {
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  i =
=3D i + pi_44;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  }
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  continue;
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  } else if (pattern[pi_34] !=3D tex=
t[i + pi_34]) {
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  last_failed_index =
=3D pi_34;
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  // this character =
doesn't appear in pattern, so
> >     skip
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  if (pattern_char[(=
int)(text[i + pi_34])] =3D=3D 0) {
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  i =
=3D i + pi_34;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  }
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  continue;
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  } else if (pattern[pi_24] !=3D tex=
t[i + pi_24]) {
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  last_failed_index =
=3D pi_24;
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  // this character =
doesn't appear in pattern, so
> >     skip
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  if (pattern_char[(=
int)(text[i + pi_24])] =3D=3D 0) {
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  i =
=3D i + pi_24;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  }
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  continue;
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  } else if (pattern[pi_14] !=3D tex=
t[i + pi_14]) {
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  last_failed_index =
=3D pi_14;
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  // this character =
doesn't appear in pattern, so
> >     skip
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  if (pattern_char[(=
int)(text[i + pi_14])] =3D=3D 0) {
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  i =
=3D i + pi_14;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  }
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  continue;
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  } // end of if-else.. block
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  // compare with character at last =
failed index.
> >     >=C3=82  =C3=82  =C3=82  =C3=82  if (last_failed_index >=3D 0) {
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  if (pattern[last_f=
ailed_index] !=3D text[i +
> >     last_failed_index]) {
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  co=
ntinue;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  }
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  }
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  if (pattern[0] =3D=3D text[i]) {
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  //full_pattern_sea=
rch =3D full_pattern_search + 1;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  end_index =3D i + =
pi_44;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  not_found =3D fals=
e;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  int index =3D 0;
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  for (index =3D i; =
index <=3D end_index; index++) {
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  if=
 (text[index] !=3D pattern[index - i]) {
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =
=C3=82  =C3=82  last_failed_index =3D index - i;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =
=C3=82  =C3=82  not_found =3D true;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =
=C3=82  =C3=82  break;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  }
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  } // end of inner =
for loop
> >     >
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  if (not_found =3D=
=3D false) { // match is found
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  re=
turn (text + i);
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  //=
return i;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  } else if (pattern=
_char[(int)(text[index])] =3D=3D 0)
> >     {
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  i =
=3D index;
> >     >=C3=82  =C3=82  =C3=82  =C3=82  =C3=82  =C3=82  }
> >     >=C3=82  =C3=82  =C3=82  =C3=82  } // end of if pattern[0]
> >     >
> >     >=C3=82  =C3=82  } // end of outer for loop
> >     >
> >     >=C3=82  =C3=82  return NULL;
> >     >=C3=82  =C3=82  //return -1;
> >     >
> >     >} // end of choudhary_string_search_algorithm
> >     >
> >     >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     >
> >     >Regards,
> >     >Amit
> >
> >References
> >
> >   1. mailto:unixbhaskar@gmail.com
