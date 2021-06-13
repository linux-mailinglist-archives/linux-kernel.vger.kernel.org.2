Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726523A571E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 10:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhFMIct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 04:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhFMIcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 04:32:48 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD917C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 01:30:31 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r198so15673388lff.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=h6QDfB2j0vKGv3l2Nfgo+4vCqj7qjxJi6oDPysnG+BM=;
        b=JOfcuLf2Vgmywg6sOCrM/4UcoGnw1E3cD7uRZxB4mLTZKsH2eMHJi/ZzxcbYACVxdp
         FDRdCSD2i7XNDVCdhJV45y3OI9ZrABxKBNMDCoIqX9lI2yKTIHU8fJQfHPFWkUZaBtdu
         k8MfVMPsZHzHRTPk6z77A9cM1hNTdSlljdU3g7S04G1NMfOIpwvIpVg32v/EYoWQaKB4
         RysbdEgXutyAtRmUkcORpbJaxFMms574DOZaf8jbH8QFH+/DFqcTRd2ydj9Tv2yKpFue
         WJAXFH8Xvn2zKdzJ08QeJ5NyWWC/a0OvKzhJ5HKVT8t+h4lRlEQG2e1N9OaLXg6ZGSEB
         uq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h6QDfB2j0vKGv3l2Nfgo+4vCqj7qjxJi6oDPysnG+BM=;
        b=Nn6SUQo/j8HLCQZoHKrui6XdmLbwGga0pm34q3o3XGQJz1Xp/gFD0pJGrm6Zd8gc22
         U+8jK2zK90rv2yi4MBQ6FZuWq7u+giVxQJ7yWyZrF0laWCqyyE7bRtShBPgtSDQn5hQa
         Zcs558HtNUiq6hKu18j22qQHxIUSA0hxfyEgiEocRja/mYMX5ZEGMKv1tLiES2zzxOO9
         VTN4vBgAGeBEgUX7J+taKWXdlCpdL/U3ezBkVwzUqA2bHtK8Nqsj4O5CiGq2yMOq/BSe
         g4/6hFdiVgBpKgS2rqX2MPCOXRqOXYov85X8BPpAlOk4/ZwrtiBgkNKYq+e34aOgnbkI
         DJrA==
X-Gm-Message-State: AOAM533tYCGrOPPym/jBwB9RQDKESKEUM/PrIZVrkcYPzFSVEyvjmLW/
        8DzrJPfHy83kapBb4fIuUBhxQ5dG5JmBubOB1E12EL54y3Cujw==
X-Google-Smtp-Source: ABdhPJyrzOy0fBlF3bbFyaPewyHL0wWbWrxQ70bPCC569SqgnpWDGvuqBuEPTJe/Eh14aCwb1PuIQySrrJ4N1n05vEc=
X-Received: by 2002:a19:7015:: with SMTP id h21mr8604544lfc.299.1623573029798;
 Sun, 13 Jun 2021 01:30:29 -0700 (PDT)
MIME-Version: 1.0
From:   Amit Choudhary <amitchoudhary0523@gmail.com>
Date:   Sun, 13 Jun 2021 14:00:18 +0530
Message-ID: <CAFf+5zhSH_dJ2Zc5EcfqgTew8w0sEu4hLjKYf3fTmqB5mdgfwQ@mail.gmail.com>
Subject: [Code] Fastest String Search Algorithm.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have invented a new string search algorithm. It has performed better
than strstr(), Boyer-Moore, and KPM algorithms.

But I am not sending my code so that my algorithm gets included in linux kernel.

I am sending this code because linux kernel mailing list is in public
domain and getting indexed by search engines. So, people can see this
algo if they search for fastest string search algorithm on web.

Code:

===================================================================================

// Choudhary string search algorithm
static char * choudhary_string_search_algorithm(char *text, char *pattern)
{

#define false 0
#define true 1
#define ALPHABET_SIZE 256

    int i = 0;
    int end_index = 0;
    int not_found = false;

    char pattern_char[ALPHABET_SIZE] = {0};

    int text_len = strlen(text);
    int pattern_len = strlen(pattern);

    int pi_44 = pattern_len - 1;
    int pi_34 = (3 * pattern_len) / 4;
    int pi_24 = pattern_len / 2;
    int pi_14 = pattern_len / 4;

    int last_failed_index = -1;

    // preprocessing
    for (i = 0; i < pattern_len; i++) {
        pattern_char[(int)(pattern[i])] = 1;
    }

    // now search
    for (i = 0; i < text_len; i++) {

        if ((text_len - i) < pattern_len) {
            return NULL;
            //return -1;
        }

        if (pattern[pi_44] != text[i + pi_44]) {

            last_failed_index = pi_44;

            // this character doesn't appear in pattern, so skip
            if (pattern_char[(int)(text[i + pi_44])] == 0) {
                i = i + pi_44;
            }

            continue;

        } else if (pattern[pi_34] != text[i + pi_34]) {

            last_failed_index = pi_34;

            // this character doesn't appear in pattern, so skip
            if (pattern_char[(int)(text[i + pi_34])] == 0) {
                i = i + pi_34;
            }

            continue;

        } else if (pattern[pi_24] != text[i + pi_24]) {

            last_failed_index = pi_24;

            // this character doesn't appear in pattern, so skip
            if (pattern_char[(int)(text[i + pi_24])] == 0) {
                i = i + pi_24;
            }

            continue;

        } else if (pattern[pi_14] != text[i + pi_14]) {

            last_failed_index = pi_14;

            // this character doesn't appear in pattern, so skip
            if (pattern_char[(int)(text[i + pi_14])] == 0) {
                i = i + pi_14;
            }

            continue;

        } // end of if-else.. block

        // compare with character at last failed index.
        if (last_failed_index >= 0) {

            if (pattern[last_failed_index] != text[i + last_failed_index]) {
                continue;
            }

        }

        if (pattern[0] == text[i]) {

            //full_pattern_search = full_pattern_search + 1;
            end_index = i + pi_44;
            not_found = false;
            int index = 0;

            for (index = i; index <= end_index; index++) {
                if (text[index] != pattern[index - i]) {
                    last_failed_index = index - i;
                    not_found = true;
                    break;
                }
            } // end of inner for loop

            if (not_found == false) { // match is found
                return (text + i);
                //return i;
            } else if (pattern_char[(int)(text[index])] == 0) {
                i = index;
            }
        } // end of if pattern[0]

    } // end of outer for loop

    return NULL;
    //return -1;

} // end of choudhary_string_search_algorithm

===================================================================================

Regards,
Amit
