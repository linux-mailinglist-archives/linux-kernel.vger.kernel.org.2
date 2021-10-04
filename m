Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18514216D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbhJDSyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbhJDSyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:54:51 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6CAC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 11:53:01 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y23so36461977lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 11:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4Fzk1DP0iayGOUpBybh1gut82WZWDwY9rleUxOqsp8=;
        b=cnMNjYq+Dy3l20WiGyrX1Uxka7OaBVUCGiVE54AostVGh3EVZFPZTZzZgj5I1ZMqvp
         2hkewQBGVtnxiBzeDlcTt1vZ4saaiyLndxK/OFrCE+QPcZEv7m/8IjgYRDwZQvnCrKgO
         kg+cWNzW+BhZ59nSvbG+RnIMTfSJgmSmR12mdM4I3LhK252KntZvMdZCd+J3hRyDozTw
         7wHHA2uNmIDQBv5efjS03Yx+NkzY5xX0a/AKMMJ3Hk9h6txC0kCvT6gCizigbonnkQi0
         vc2XSaT/YxovZ77sSX53UATwW2PDLNG6lmda/VyMKyuP9S8Vo2dFb+J2rZqqziKnVHe9
         1MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4Fzk1DP0iayGOUpBybh1gut82WZWDwY9rleUxOqsp8=;
        b=rs/Tno9D+6Th4Wqs4IEAOIzpU9Ic6UgT+bzOgfU1RUOjJvAi1pYTiv3PTMOj5YSSOY
         rDXLCi27xkOw7ix8f8Kq28gX2miFm2X4Pq7CYvWJMl4TGEPvp+G0Ef3clZVMqcaz51tt
         qM7pAYbg7+0d0luqpLqtnEX4Y6eza3i04W30Euzg7oRWylLoB72QyQSSPszX+rXRAz0H
         c0g1IgIiX3u5/yv+qUJ6sVc7ru342VOLbuhhgUi+SfeqtEO2Ob2jI01GwTAta1/yyPsO
         DyPWLPVhQ+h9lvApORPpTMtdrI6VhSFCaYQ6xD/XOo0jLafgavVYGRkgHB1H1PWH+5e0
         C+Xg==
X-Gm-Message-State: AOAM530Rtdwfz5OyXd88zUaLaoiESAU3xAvseljDiqD5QaZSRpbR4OiN
        SXY+Az8ppcRGkMkOuzsr3ScEctmMrsPgA4ES47iecQ==
X-Google-Smtp-Source: ABdhPJyy4xzn87jmamSqt98VNPTlglPs3dzyEhgNhHLDPgnDh7pmAiJ4SR8NxEHMxPv00rN+mcR1Ud/db0YRq9e9ccU=
X-Received: by 2002:a05:6512:311:: with SMTP id t17mr9613389lfp.82.1633373579655;
 Mon, 04 Oct 2021 11:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <202110020501.RKX4zca7-lkp@intel.com> <20211004162936.21961-1-ndesaulniers@google.com>
 <163337043811.3396838.458236649388694225.b4-ty@chromium.org>
 <CAKwvOdm5bBUE0df8jbXq+bSCf9U0AM3Wm4NsZeHu=Nuhi0yd-A@mail.gmail.com>
 <20211004183806.5weyuk554ppe5olb@meerkat.local> <CAKwvOdkzviryHByOZj1K6r6HVKcC+4Tc43jXn4Eqk9EXGVpucg@mail.gmail.com>
 <20211004184708.nxkd3si45vzj5c7k@meerkat.local>
In-Reply-To: <20211004184708.nxkd3si45vzj5c7k@meerkat.local>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Oct 2021 11:52:48 -0700
Message-ID: <CAKwvOdmyGk9yVpdXo7Zg7n3NgsYw9WP--9_X55wZtQxoRPQoLw@mail.gmail.com>
Subject: Re: [PATCH v6] kallsyms: strip LTO suffixes from static functions
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000000d62905cd8b6c4c"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000000d62905cd8b6c4c
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 4, 2021 at 11:47 AM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Mon, Oct 04, 2021 at 11:41:29AM -0700, Nick Desaulniers wrote:
> > On Mon, Oct 4, 2021 at 11:38 AM Konstantin Ryabitsev
> > <konstantin@linuxfoundation.org> wrote:
> > >
> > > On Mon, Oct 04, 2021 at 11:32:43AM -0700, Nick Desaulniers wrote:
> > > > $ git format-patch HEAD~
> > > > 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch
> > > > $ git send-email --suppress-cc=body --to keescook@chromium.org
> > > > 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch
> > > > patatt: E: -: Not a valid RFC2822 message
> > > > fatal: 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch:
> > > > rejected by sendemail-validate hook
> > > > fatal: command 'git hook run sendemail-validate -- <patch>' died with
> > > > exit code 1
> > > > warning: no patches were sent
> > >
> > > Woah. What git version is this?
> >
> > $ git --version
> > git version 2.33.0.800.g4c38ced690-goog
> >
> > Looks like some corporate version...anything else I can to do to help
> > debug? (Moving explicit CC's to BCC).
>
> Yeah, can you please send me
> 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch as an attachment?

Sure, attached via gmail web client.

> Also, the output of running "locale" -- it's got to be something to do with
> passing stdin as opposed ot loading from file.

$ locale
LANG=en_US.UTF-8
LANGUAGE=
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=


As a heads up, I sent a PR, too: https://github.com/mricon/patatt/pull/1.

-- 
Thanks,
~Nick Desaulniers

--00000000000000d62905cd8b6c4c
Content-Type: application/octet-stream; 
	name="0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch"
Content-Disposition: attachment; 
	filename="0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kud0exnf0>
X-Attachment-Id: f_kud0exnf0

RnJvbSBlODI0MWNmZGE0ZGE3ZGI1NWE4N2Y2MTIwMDczMWRlMThjZDcyMjJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xl
LmNvbT4KRGF0ZTogV2VkLCAyOSBTZXAgMjAyMSAxMjoyMDoyNCAtMDcwMApTdWJqZWN0OiBbUEFU
Q0hdIEFSTTogbW06IHByb2MtbWFjcm9zOiBlbnN1cmUgKl90bGJfZm5zIGFyZSA0QiBhbGlnbmVk
CgpBIGtlcm5lbCBidWlsdCB3aXRoIENPTkZJR19USFVNQjJfS0VSTkVMPXkgYW5kIHVzaW5nIGNs
YW5nIGFzIHRoZQphc3NlbWJsZXIgY291bGQgZ2VuZXJhdGUgbm9uLW5hdHVyYWxseS1hbGlnbmVk
IHY3d2JpX3RsYl9mbnMgd2hpY2gKcmVzdWx0cyBpbiBhIGJvb3QgZmFpbHVyZS4gVGhlIG9yaWdp
bmFsIGNvbW1pdCBhZGRpbmcgdGhlIG1hY3JvIG1pc3NlZAp0aGUgLmFsaWduIGRpcmVjdGl2ZSBv
biB0aGlzIGRhdGEuCgpGaXhlczogNjZhNjI1YTg4MTc0ICgiQVJNOiBtbTogcHJvYy1tYWNyb3M6
IEFkZCBnZW5lcmljIHByb2MvY2FjaGUvdGxiIHN0cnVjdCBkZWZpbml0aW9uIG1hY3JvcyIpCkxp
bms6IGh0dHBzOi8vZ2l0aHViLmNvbS9DbGFuZ0J1aWx0TGludXgvbGludXgvaXNzdWVzLzE0NDcK
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzA2OTlkYTdiLTM1NGYtYWVjYy1hNjJm
LWUyNTY5MzIwOWFmNEBsaW5hcm8ub3JnLwpEZWJ1Z2dlZC1ieTogQXJkIEJpZXNoZXV2ZWwgPGFy
ZGJAa2VybmVsLm9yZz4KRGVidWdnZWQtYnk6IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2Vy
bmVsLm9yZz4KRGVidWdnZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNv
bkBsaW5hcm8ub3JnPgpTdWdnZXN0ZWQtYnk6IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5v
cmc+CkFja2VkLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPgpTaWduZWQtb2Zm
LWJ5OiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4KVGVzdGVkLWJ5
OiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0aGFuQGtlcm5lbC5vcmc+Ci0tLQogYXJjaC9hcm0vbW0v
cHJvYy1tYWNyb3MuUyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vbW0vcHJvYy1tYWNyb3MuUyBiL2FyY2gvYXJtL21tL3Byb2MtbWFj
cm9zLlMKaW5kZXggZTJjNzQzYWEyZWIyLi5kOWY3ZGZlMmE3ZWQgMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtL21tL3Byb2MtbWFjcm9zLlMKKysrIGIvYXJjaC9hcm0vbW0vcHJvYy1tYWNyb3MuUwpAQCAt
MzQwLDYgKzM0MCw3IEBAIEVOVFJZKFxuYW1lXCgpX2NhY2hlX2ZucykKIAogLm1hY3JvIGRlZmlu
ZV90bGJfZnVuY3Rpb25zIG5hbWU6cmVxLCBmbGFnc191cDpyZXEsIGZsYWdzX3NtcAogCS50eXBl
CVxuYW1lXCgpX3RsYl9mbnMsICNvYmplY3QKKwkuYWxpZ24gMgogRU5UUlkoXG5hbWVcKClfdGxi
X2ZucykKIAkubG9uZwlcbmFtZVwoKV9mbHVzaF91c2VyX3RsYl9yYW5nZQogCS5sb25nCVxuYW1l
XCgpX2ZsdXNoX2tlcm5fdGxiX3JhbmdlCi0tIAoyLjMzLjAuODAwLmc0YzM4Y2VkNjkwLWdvb2cK
Cg==
--00000000000000d62905cd8b6c4c--
