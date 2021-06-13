Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02523A57B3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 12:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhFMKcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 06:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhFMKcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 06:32:53 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA889C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 03:30:51 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v22so16002566lfa.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=J/2tGPrXfOAj/oCrXNVEWB8pkHxFBTQvD2JNFMyBZ5Y=;
        b=VBIs6IbT3HJNG49Js3Zqlkd5+C/KTmMPktiUXDcsILprUmUeYH2/7rpL10rk1+J+uv
         oqoSoeGp3zQpwiOZ4wAyCwYLoqUZlY35kbUx4iKtcQcZjDV9D4KcbBvq/AO3vSzt70U9
         JGXHyAZnO2bnhRsGbY1DpNk9EZ1yAL7q/XB96G7YMUrn4FutoS4z4cSuJ+RVsNuizgV4
         1WHI0wABTRZJhe4O9o73CH9Vx6MC5+801lRMX9bYaeg8AqhCDzKae8JcSfVwQbC40WXQ
         0VvZe9i3G2tT6sXnuEtTsXKDbo9OEHmgl4P+C9qgkq/ukR8LyDvCxdVM6q7H2n3B4MJ3
         IYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=J/2tGPrXfOAj/oCrXNVEWB8pkHxFBTQvD2JNFMyBZ5Y=;
        b=YIJPga5z2iwIBOzQJAklNDIaMFKcdrjbiLkAPkCJAXvjp/BDEMqjZdTkn/pYGecMYo
         63EdYnlMjT1elSMfWGw/oSG250yBI/EIYV4fXJzly2M4Ltjv5rso/sTp6zCftg7GKnaG
         ENevKuMBoNrzr5tgX7OnoqoXjRdVFlqRs1YUFjSIDzysvtQBbcK41XxdyyNJfXrfze10
         sMP0oOV3gYdejUjzEK3AJtXmkrziqr7jEW3K3vjUt4LWRUr2AKbWk2YwQgupd4ONgi/G
         8te2EP58ExsH62vw5hBzqEjIMwrC7qiAo0c+fPS7TwYLBaeJzNWxgdmH+jYiQE+VXzV+
         xLbQ==
X-Gm-Message-State: AOAM530r2GP7Ri9LnXQ9YDzOHZpRl1wilLMHiTX7LIJZ0ZOfDg56uRAd
        bYAUTIi6mPuKYSLn+Wd4Plvq5iT4K4NDPEdf4dg=
X-Google-Smtp-Source: ABdhPJwtr29uNw7zYIpcGl4b7oqwEg6+wjWO5vGpyWoVX+K56Zbrs4ArzVB56uP+P805P0tl1VAPjl+ilTCEXs8o6V8=
X-Received: by 2002:a05:6512:388f:: with SMTP id n15mr9329453lft.280.1623580250149;
 Sun, 13 Jun 2021 03:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAFf+5zhSH_dJ2Zc5EcfqgTew8w0sEu4hLjKYf3fTmqB5mdgfwQ@mail.gmail.com>
 <YMXYYgR82VZISjtO@ArchLinux>
In-Reply-To: <YMXYYgR82VZISjtO@ArchLinux>
From:   Amit Choudhary <amitchoudhary0523@gmail.com>
Date:   Sun, 13 Jun 2021 16:00:41 +0530
Message-ID: <CAFf+5zhydkMMYd9cDJMzc8_YhLWdoQ6YTnDV5AJoXgF3tVHqsA@mail.gmail.com>
Subject: Re: [Code] Fastest String Search Algorithm.
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Amit Choudhary <amitchoudhary0523@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhaskar,

Fuck you.

You are not the owner of linux kernel.

You are a very big idiot.

You really don't know who you are talking to.

You are just assuming that I am a stupid guy without knowing anything about me.

My linux kernel patches are in linux kernel since 2005-2006.

What are your educational and professional qualifications?

I don't think you are from IIT like me, probably you are from a third
grade donation based college.

I have invented a new search engine architecture and implemented it
and it is hosted on sourceforge.

Have you ever invented anything?

World is full of idiots like you from India who think that they are
supreme and other Indians are fools.

Amit



On Sun, Jun 13, 2021, 3:35 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
> On 14:00 Sun 13 Jun 2021, Amit Choudhary wrote:
>
> Ahhhhhhhh...
>
> Oh crap! Get off the lawn , kiddo. Do NOT USE THIS PLACE for your obnoxious
> desire.
>
> We don't have time and energy to evaluate some airy-fairy stuff .
>
> How do you know we will ever bother to think about "include your code"?? Let
> alone other factor...huh...you are living in fool's paradise ...meh... look
> like your head is filled with lots of preconceived dogma....where have you got
> those?? Heck..
>
> Your intention is not wise...this mailing list solely exist for people
> interested in Linux and only in Linux Kernel. Period.
>
> IOW , PLEASE DO NOT BOTHER US.
>
> ~Bhaskar
>
> >Hi All,
> >
> >I have invented a new string search algorithm. It has performed better
> >than strstr(), Boyer-Moore, and KPM algorithms.
> >
> >But I am not sending my code so that my algorithm gets included in linux kernel.
> >
> >I am sending this code because linux kernel mailing list is in public
> >domain and getting indexed by search engines. So, people can see this
> >algo if they search for fastest string search algorithm on web.
> >
> >Code:
> >
> >===================================================================================
> >
> >// Choudhary string search algorithm
> >static char * choudhary_string_search_algorithm(char *text, char *pattern)
> >{
> >
> >#define false 0
> >#define true 1
> >#define ALPHABET_SIZE 256
> >
> >    int i = 0;
> >    int end_index = 0;
> >    int not_found = false;
> >
> >    char pattern_char[ALPHABET_SIZE] = {0};
> >
> >    int text_len = strlen(text);
> >    int pattern_len = strlen(pattern);
> >
> >    int pi_44 = pattern_len - 1;
> >    int pi_34 = (3 * pattern_len) / 4;
> >    int pi_24 = pattern_len / 2;
> >    int pi_14 = pattern_len / 4;
> >
> >    int last_failed_index = -1;
> >
> >    // preprocessing
> >    for (i = 0; i < pattern_len; i++) {
> >        pattern_char[(int)(pattern[i])] = 1;
> >    }
> >
> >    // now search
> >    for (i = 0; i < text_len; i++) {
> >
> >        if ((text_len - i) < pattern_len) {
> >            return NULL;
> >            //return -1;
> >        }
> >
> >        if (pattern[pi_44] != text[i + pi_44]) {
> >
> >            last_failed_index = pi_44;
> >
> >            // this character doesn't appear in pattern, so skip
> >            if (pattern_char[(int)(text[i + pi_44])] == 0) {
> >                i = i + pi_44;
> >            }
> >
> >            continue;
> >
> >        } else if (pattern[pi_34] != text[i + pi_34]) {
> >
> >            last_failed_index = pi_34;
> >
> >            // this character doesn't appear in pattern, so skip
> >            if (pattern_char[(int)(text[i + pi_34])] == 0) {
> >                i = i + pi_34;
> >            }
> >
> >            continue;
> >
> >        } else if (pattern[pi_24] != text[i + pi_24]) {
> >
> >            last_failed_index = pi_24;
> >
> >            // this character doesn't appear in pattern, so skip
> >            if (pattern_char[(int)(text[i + pi_24])] == 0) {
> >                i = i + pi_24;
> >            }
> >
> >            continue;
> >
> >        } else if (pattern[pi_14] != text[i + pi_14]) {
> >
> >            last_failed_index = pi_14;
> >
> >            // this character doesn't appear in pattern, so skip
> >            if (pattern_char[(int)(text[i + pi_14])] == 0) {
> >                i = i + pi_14;
> >            }
> >
> >            continue;
> >
> >        } // end of if-else.. block
> >
> >        // compare with character at last failed index.
> >        if (last_failed_index >= 0) {
> >
> >            if (pattern[last_failed_index] != text[i + last_failed_index]) {
> >                continue;
> >            }
> >
> >        }
> >
> >        if (pattern[0] == text[i]) {
> >
> >            //full_pattern_search = full_pattern_search + 1;
> >            end_index = i + pi_44;
> >            not_found = false;
> >            int index = 0;
> >
> >            for (index = i; index <= end_index; index++) {
> >                if (text[index] != pattern[index - i]) {
> >                    last_failed_index = index - i;
> >                    not_found = true;
> >                    break;
> >                }
> >            } // end of inner for loop
> >
> >            if (not_found == false) { // match is found
> >                return (text + i);
> >                //return i;
> >            } else if (pattern_char[(int)(text[index])] == 0) {
> >                i = index;
> >            }
> >        } // end of if pattern[0]
> >
> >    } // end of outer for loop
> >
> >    return NULL;
> >    //return -1;
> >
> >} // end of choudhary_string_search_algorithm
> >
> >===================================================================================
> >
> >Regards,
> >Amit
