Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A653A577C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 12:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhFMKIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 06:08:50 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:35670 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhFMKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 06:08:49 -0400
Received: by mail-qk1-f182.google.com with SMTP id g19so2908647qkk.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 03:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Au4QKTus+XgKR2vBRU7aKb0qORCXsYtbUG6Uiq/nA7E=;
        b=Wa+LSpR6IORg8oWvqY30jJsiSDLCW5trlKsbwjQ3HWYA/l+wbCz2LpXVxfjeF543bJ
         W2J5kJqNn1wowxtqoIdAGNxCVWYyfITFZrmNBpboNAJDVbZm1KmTdsJllSXTeGc5+FSG
         p714uKWBqaHKvZppn2CIVeN7xXkxftObhA0sPqWryVzT7K4IS/YOMQ7Xh0opfKGtixBy
         O0Ondcpbl/eJwWUSwzTzfepxm5xIL2cVxBezBRMhPyAMG8nbsI4mrsIP5KiWKUHyS4Xb
         YuSB0yAG6w0qjMZlq7dXAHT2JKUXwnLbT4EL9EcUynWWS193URRFbT4OXoc/9lROytdQ
         3q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Au4QKTus+XgKR2vBRU7aKb0qORCXsYtbUG6Uiq/nA7E=;
        b=k5UmD5tOJ0Df+xwT3+kywybHstmuE5bIStzJAgf3a9e7wOfEZ28C6V7VCNSBo9MNYq
         oMuahqVNSwF+Kh1pNEnFGgEh09kG9+vt5bR2eL0OeBGzqqe/wDGtyeCqTsdHuSPRDE7I
         lrbw1xYSkt/5nqk0HMRfTqw85noMYMQfvvhuEinyiqeDSMhkds+HXIqbKXLqpM3HtN8u
         ALimUmQE8A9L9XhtW/ruGMVaXOPncGEKvg3BGRe71F3dAZRrKeJTL0EBqXflC8xBVWM6
         JE2yktg6sYnB7Dsj+gzm1Wipu2En0lMydlazmjKQh86gSow/e3FwByxaJicx1Ea1ubQh
         eQ8g==
X-Gm-Message-State: AOAM530IumpnfeGfruYQxdyIFHkjpmUxMQRCVAu3M9/5Fwi8dzMqeDxB
        3gTMmQLB634wmojV8SxRq7IO2a0gaj8u2w==
X-Google-Smtp-Source: ABdhPJwi4w2WDz064TubEJdv3YJV+YdWzyf9aJBBVe3kRA/6UrIsc+YNrZfgRzc0+ZwGLvikxTUWEQ==
X-Received: by 2002:a05:620a:29d4:: with SMTP id s20mr11568627qkp.287.1623578738291;
        Sun, 13 Jun 2021 03:05:38 -0700 (PDT)
Received: from ArchLinux ([191.96.227.140])
        by smtp.gmail.com with ESMTPSA id w4sm7552046qtv.79.2021.06.13.03.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 03:05:37 -0700 (PDT)
Date:   Sun, 13 Jun 2021 15:35:22 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Amit Choudhary <amitchoudhary0523@gmail.com>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: [Code] Fastest String Search Algorithm.
Message-ID: <YMXYYgR82VZISjtO@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Amit Choudhary <amitchoudhary0523@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
References: <CAFf+5zhSH_dJ2Zc5EcfqgTew8w0sEu4hLjKYf3fTmqB5mdgfwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A62bU5pp696mrwWI"
Content-Disposition: inline
In-Reply-To: <CAFf+5zhSH_dJ2Zc5EcfqgTew8w0sEu4hLjKYf3fTmqB5mdgfwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A62bU5pp696mrwWI
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:00 Sun 13 Jun 2021, Amit Choudhary wrote:

Ahhhhhhhh...

Oh crap! Get off the lawn , kiddo. Do NOT USE THIS PLACE for your obnoxious
desire.

We don't have time and energy to evaluate some airy-fairy stuff .

How do you know we will ever bother to think about "include your code"?? Let
alone other factor...huh...you are living in fool's paradise ...meh... look
like your head is filled with lots of preconceived dogma....where have you got
those?? Heck..

Your intention is not wise...this mailing list solely exist for people
interested in Linux and only in Linux Kernel. Period.

IOW , PLEASE DO NOT BOTHER US.

~Bhaskar

>Hi All,
>
>I have invented a new string search algorithm. It has performed better
>than strstr(), Boyer-Moore, and KPM algorithms.
>
>But I am not sending my code so that my algorithm gets included in linux kernel.
>
>I am sending this code because linux kernel mailing list is in public
>domain and getting indexed by search engines. So, people can see this
>algo if they search for fastest string search algorithm on web.
>
>Code:
>
>===================================================================================
>
>// Choudhary string search algorithm
>static char * choudhary_string_search_algorithm(char *text, char *pattern)
>{
>
>#define false 0
>#define true 1
>#define ALPHABET_SIZE 256
>
>    int i = 0;
>    int end_index = 0;
>    int not_found = false;
>
>    char pattern_char[ALPHABET_SIZE] = {0};
>
>    int text_len = strlen(text);
>    int pattern_len = strlen(pattern);
>
>    int pi_44 = pattern_len - 1;
>    int pi_34 = (3 * pattern_len) / 4;
>    int pi_24 = pattern_len / 2;
>    int pi_14 = pattern_len / 4;
>
>    int last_failed_index = -1;
>
>    // preprocessing
>    for (i = 0; i < pattern_len; i++) {
>        pattern_char[(int)(pattern[i])] = 1;
>    }
>
>    // now search
>    for (i = 0; i < text_len; i++) {
>
>        if ((text_len - i) < pattern_len) {
>            return NULL;
>            //return -1;
>        }
>
>        if (pattern[pi_44] != text[i + pi_44]) {
>
>            last_failed_index = pi_44;
>
>            // this character doesn't appear in pattern, so skip
>            if (pattern_char[(int)(text[i + pi_44])] == 0) {
>                i = i + pi_44;
>            }
>
>            continue;
>
>        } else if (pattern[pi_34] != text[i + pi_34]) {
>
>            last_failed_index = pi_34;
>
>            // this character doesn't appear in pattern, so skip
>            if (pattern_char[(int)(text[i + pi_34])] == 0) {
>                i = i + pi_34;
>            }
>
>            continue;
>
>        } else if (pattern[pi_24] != text[i + pi_24]) {
>
>            last_failed_index = pi_24;
>
>            // this character doesn't appear in pattern, so skip
>            if (pattern_char[(int)(text[i + pi_24])] == 0) {
>                i = i + pi_24;
>            }
>
>            continue;
>
>        } else if (pattern[pi_14] != text[i + pi_14]) {
>
>            last_failed_index = pi_14;
>
>            // this character doesn't appear in pattern, so skip
>            if (pattern_char[(int)(text[i + pi_14])] == 0) {
>                i = i + pi_14;
>            }
>
>            continue;
>
>        } // end of if-else.. block
>
>        // compare with character at last failed index.
>        if (last_failed_index >= 0) {
>
>            if (pattern[last_failed_index] != text[i + last_failed_index]) {
>                continue;
>            }
>
>        }
>
>        if (pattern[0] == text[i]) {
>
>            //full_pattern_search = full_pattern_search + 1;
>            end_index = i + pi_44;
>            not_found = false;
>            int index = 0;
>
>            for (index = i; index <= end_index; index++) {
>                if (text[index] != pattern[index - i]) {
>                    last_failed_index = index - i;
>                    not_found = true;
>                    break;
>                }
>            } // end of inner for loop
>
>            if (not_found == false) { // match is found
>                return (text + i);
>                //return i;
>            } else if (pattern_char[(int)(text[index])] == 0) {
>                i = index;
>            }
>        } // end of if pattern[0]
>
>    } // end of outer for loop
>
>    return NULL;
>    //return -1;
>
>} // end of choudhary_string_search_algorithm
>
>===================================================================================
>
>Regards,
>Amit

--A62bU5pp696mrwWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmDF2F8ACgkQsjqdtxFL
KRWryAf/XUHCnPR4i3X4E44fNoJz8vUw8MWjMYqIz3NGwqSzC9qQF+dRxGRYXnGz
zmJKBmtGIw2l8Kmv7QLQMoY0qeHG6s/nxcXpW7Recry8HaEc3et8XPzZUdtdakpL
eAGRYTXZPiBl5dFru2ZjqoXMGXbnyPNBUtKUFfwBEDx3UHyQS/OjjXOloq7dfn3h
0FUnmWw0fYZ1pM8QmabmvkIy7NjNIHJV5u9IdqvWdShc1SqJ1IAyfUO224Fh/MIl
SyMaxYecGeC++Q9pbnjE2Rg12I51pcA7tifX3hmQKbuUaNMA+2bdPpkGwQtvWugr
Y9+qtspj9TmpQOzmVJGeY/Wdl+Qv6w==
=s03S
-----END PGP SIGNATURE-----

--A62bU5pp696mrwWI--
