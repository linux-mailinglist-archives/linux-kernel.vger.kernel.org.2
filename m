Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66D33505F2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhCaSDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhCaSDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:03:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869C1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:03:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u9so24887586ljd.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXfb19gNg7/K8AS1cdqWjszcSh1b9YtfAjO2coDW7Kk=;
        b=OaUZTxfV50pnJHUgV8gUCX9AlxXh7zuAp/OEe4SPSN9wybozy1HWhQVdJtzYzKdE2M
         9sa52CSu2UCKU2HKifAiIFPNOhqZ9xGjONTh69lMG/04H59ivUVfWz9aJzF8wcxJ72JR
         Jh+felqzb7aedtiufqDDvH7F2MJ/FHkBYGkL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXfb19gNg7/K8AS1cdqWjszcSh1b9YtfAjO2coDW7Kk=;
        b=oDU9amoIpwIgq+ZGMTXoeyL0BoZ6eVYmgY89NokG2B2c+PIDLb1l0W1oCVWT3PPGXx
         KDzFJZN7sitmdqrF1Nl3N7vXHxplAP/fyDCZNuHnQuUhWgTYTCcRGJymx1srhTdRq0Bx
         VZkH9bUINQQMJ8rrPvjbLRukZUewS6VYXhfDCTTB8jqj2vYFRj6H+HRVkkC2TrrcShh1
         oYIgv3adJc0aaqDmcnLzDca83ddou5H7aYh47ZTz3NhreCjNPgGPjyVYSEGhyd8KAKEt
         DdfZUyvShVtSgGvj6xV1qTHA2d/Dey/yUf7Jx7bAhVI2kww2Wg3zHKmgRBhPt0bPJk55
         ZFjA==
X-Gm-Message-State: AOAM530XyISc0uRm1Ppd/17XV+X/S7gQppF4+zQzEkyrWhuj6CKgLAx3
        xJtjEBHhcU+3KxcrddS6R4s5MEc4JKpF4v+K
X-Google-Smtp-Source: ABdhPJyRswA/lpPXvriZNsHlUSdnjequQhBTMiTz1btrTp3WnpCLkF3p8y565VfWJOq55DdA2yvG9g==
X-Received: by 2002:a2e:9a03:: with SMTP id o3mr2814982lji.501.1617213818771;
        Wed, 31 Mar 2021 11:03:38 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id i7sm316660lja.15.2021.03.31.11.03.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 11:03:38 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id i26so30331902lfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:03:37 -0700 (PDT)
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr2769132lfo.201.1617213817533;
 Wed, 31 Mar 2021 11:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210331092711.2b23fcff@gandalf.local.home> <CAHk-=wjt9b7kxQ2J=aDNKbR1QBMB3Hiqb_hYcZbKsxGRSEb+gQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjt9b7kxQ2J=aDNKbR1QBMB3Hiqb_hYcZbKsxGRSEb+gQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Mar 2021 11:03:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyMxheOqXAORt9a7JK9gc9eHTgCJ55Pgs4p=X3RrQubQ@mail.gmail.com>
Message-ID: <CAHk-=whyMxheOqXAORt9a7JK9gc9eHTgCJ55Pgs4p=X3RrQubQ@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Check if pages were allocated before calling free_pages()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: multipart/mixed; boundary="0000000000001ed4c905bed8efba"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001ed4c905bed8efba
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 31, 2021 at 10:45 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, looking at that code, every single use of
> "get_count_order()" seems really really confusing.

Side note: I've pulled your fix, but I really think that the bug is
almost entirely due to the code being so opaque and crazy hard to
read. I think the real fix would be to make the code a lot clearer.

I found another bug in there, for example:

                ftrace_number_of_pages -= 1 << order;

is also wrong if order is negative.

So I think the fix is something like the attached (TOTALLY UNTESTED!!)
that does two things:

 - make the "has it been allocated" test be about "pg->records" being
non-NULL, which honestly seems to be a hell of a lot more logical.

 - get rid of the crazy "size" field that then has to be converted
into a "page order", and just keep it being the page order

 - that makes all the calculations much simpler: the size of an
allocation is (trivially) just

        PAGE_SIZE << pg->order

   and the test whether the allocation has filled up is to just see
how much space we need:

        end_offset = (pg->index+1) * sizeof(pg->records[0]);

   and then you can compare that against that trivial allocation size.

Doesn't this make the code now make SENSE? Instead of that
incomprehensible mess it was before?

I dunno. Maybe it's just my "pee in the snow" thing, but honestly, the
fact that I seem to have found another bug wrt the whole
'ftrace_number_of_pages' handling really says that the code was
garbage.

And maybe it's just me who doesn't understand the subtle perfection of
the old code, and I'm being stupid. Feel free to educate me about it.

Final note: note the "TOTALLY UNTESTED" part of the patch. The patch
CompilesForMe(tm), but please consider it a "how about something like
this" rather than anything finished.

Also note that I did *not* change the initial "order" calculation
itself in ftrace_allocate_records() in this patch. I left that
particular oddity alone. Again, I *think* the math just ends up being

        pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
        order = fls(pages)-1;

but the attached patch is not about that, it's about the crazy "pg->size" games.

            Linus

PS. TOTALLY UNTESTED!!

--0000000000001ed4c905bed8efba
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kmxrbd680>
X-Attachment-Id: f_kmxrbd680

IGtlcm5lbC90cmFjZS9mdHJhY2UuYyB8IDM1ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEva2VybmVsL3RyYWNlL2Z0cmFjZS5jIGIva2VybmVsL3RyYWNlL2Z0cmFj
ZS5jCmluZGV4IDNiYTUyZDRlMTMxNC4uOWM3NmRiMWY3MDYwIDEwMDY0NAotLS0gYS9rZXJuZWwv
dHJhY2UvZnRyYWNlLmMKKysrIGIva2VybmVsL3RyYWNlL2Z0cmFjZS5jCkBAIC0xMDkwLDcgKzEw
OTAsNyBAQCBzdHJ1Y3QgZnRyYWNlX3BhZ2UgewogCXN0cnVjdCBmdHJhY2VfcGFnZQkqbmV4dDsK
IAlzdHJ1Y3QgZHluX2Z0cmFjZQkqcmVjb3JkczsKIAlpbnQJCQlpbmRleDsKLQlpbnQJCQlzaXpl
OworCWludAkJCW9yZGVyOwogfTsKIAogI2RlZmluZSBFTlRSWV9TSVpFIHNpemVvZihzdHJ1Y3Qg
ZHluX2Z0cmFjZSkKQEAgLTMxODEsNyArMzE4MSw3IEBAIHN0YXRpYyBpbnQgZnRyYWNlX2FsbG9j
YXRlX3JlY29yZHMoc3RydWN0IGZ0cmFjZV9wYWdlICpwZywgaW50IGNvdW50KQogCWZ0cmFjZV9u
dW1iZXJfb2ZfZ3JvdXBzKys7CiAKIAljbnQgPSAoUEFHRV9TSVpFIDw8IG9yZGVyKSAvIEVOVFJZ
X1NJWkU7Ci0JcGctPnNpemUgPSBjbnQ7CisJcGctPm9yZGVyID0gb3JkZXI7CiAKIAlpZiAoY250
ID4gY291bnQpCiAJCWNudCA9IGNvdW50OwpAQCAtMzE5NCw3ICszMTk0LDYgQEAgZnRyYWNlX2Fs
bG9jYXRlX3BhZ2VzKHVuc2lnbmVkIGxvbmcgbnVtX3RvX2luaXQpCiB7CiAJc3RydWN0IGZ0cmFj
ZV9wYWdlICpzdGFydF9wZzsKIAlzdHJ1Y3QgZnRyYWNlX3BhZ2UgKnBnOwotCWludCBvcmRlcjsK
IAlpbnQgY250OwogCiAJaWYgKCFudW1fdG9faW5pdCkKQEAgLTMyMzAsMTMgKzMyMjksMTMgQEAg
ZnRyYWNlX2FsbG9jYXRlX3BhZ2VzKHVuc2lnbmVkIGxvbmcgbnVtX3RvX2luaXQpCiAgZnJlZV9w
YWdlczoKIAlwZyA9IHN0YXJ0X3BnOwogCXdoaWxlIChwZykgewotCQlvcmRlciA9IGdldF9jb3Vu
dF9vcmRlcihwZy0+c2l6ZSAvIEVOVFJJRVNfUEVSX1BBR0UpOwotCQlpZiAob3JkZXIgPj0gMCkK
LQkJCWZyZWVfcGFnZXMoKHVuc2lnbmVkIGxvbmcpcGctPnJlY29yZHMsIG9yZGVyKTsKKwkJaWYg
KHBnLT5yZWNvcmRzKSB7CisJCQlmcmVlX3BhZ2VzKCh1bnNpZ25lZCBsb25nKXBnLT5yZWNvcmRz
LCBwZy0+b3JkZXIpOworCQkJZnRyYWNlX251bWJlcl9vZl9wYWdlcyAtPSAxIDw8IHBnLT5vcmRl
cjsKKwkJfQogCQlzdGFydF9wZyA9IHBnLT5uZXh0OwogCQlrZnJlZShwZyk7CiAJCXBnID0gc3Rh
cnRfcGc7Ci0JCWZ0cmFjZV9udW1iZXJfb2ZfcGFnZXMgLT0gMSA8PCBvcmRlcjsKIAkJZnRyYWNl
X251bWJlcl9vZl9ncm91cHMtLTsKIAl9CiAJcHJfaW5mbygiZnRyYWNlOiBGQUlMRUQgdG8gYWxs
b2NhdGUgbWVtb3J5IGZvciBmdW5jdGlvbnNcbiIpOwpAQCAtNjIyMSw2ICs2MjIwLDcgQEAgc3Rh
dGljIGludCBmdHJhY2VfcHJvY2Vzc19sb2NzKHN0cnVjdCBtb2R1bGUgKm1vZCwKIAlwID0gc3Rh
cnQ7CiAJcGcgPSBzdGFydF9wZzsKIAl3aGlsZSAocCA8IGVuZCkgeworCQl1bnNpZ25lZCBsb25n
IGVuZF9vZmZzZXQ7CiAJCWFkZHIgPSBmdHJhY2VfY2FsbF9hZGp1c3QoKnArKyk7CiAJCS8qCiAJ
CSAqIFNvbWUgYXJjaGl0ZWN0dXJlIGxpbmtlcnMgd2lsbCBwYWQgYmV0d2VlbgpAQCAtNjIzMSw3
ICs2MjMxLDggQEAgc3RhdGljIGludCBmdHJhY2VfcHJvY2Vzc19sb2NzKHN0cnVjdCBtb2R1bGUg
Km1vZCwKIAkJaWYgKCFhZGRyKQogCQkJY29udGludWU7CiAKLQkJaWYgKHBnLT5pbmRleCA9PSBw
Zy0+c2l6ZSkgeworCQllbmRfb2Zmc2V0ID0gKHBnLT5pbmRleCsxKSAqIHNpemVvZihwZy0+cmVj
b3Jkc1swXSk7CisJCWlmIChlbmRfb2Zmc2V0IDwgUEFHRV9TSVpFIDw8IHBnLT5vcmRlcikgewog
CQkJLyogV2Ugc2hvdWxkIGhhdmUgYWxsb2NhdGVkIGVub3VnaCAqLwogCQkJaWYgKFdBUk5fT04o
IXBnLT5uZXh0KSkKIAkJCQlicmVhazsKQEAgLTY0MDAsNyArNjQwMSw2IEBAIHZvaWQgZnRyYWNl
X3JlbGVhc2VfbW9kKHN0cnVjdCBtb2R1bGUgKm1vZCkKIAlzdHJ1Y3QgZnRyYWNlX3BhZ2UgKips
YXN0X3BnOwogCXN0cnVjdCBmdHJhY2VfcGFnZSAqdG1wX3BhZ2UgPSBOVUxMOwogCXN0cnVjdCBm
dHJhY2VfcGFnZSAqcGc7Ci0JaW50IG9yZGVyOwogCiAJbXV0ZXhfbG9jaygmZnRyYWNlX2xvY2sp
OwogCkBAIC02NDUxLDEyICs2NDUxLDEyIEBAIHZvaWQgZnRyYWNlX3JlbGVhc2VfbW9kKHN0cnVj
dCBtb2R1bGUgKm1vZCkKIAkJLyogTmVlZHMgdG8gYmUgY2FsbGVkIG91dHNpZGUgb2YgZnRyYWNl
X2xvY2sgKi8KIAkJY2xlYXJfbW9kX2Zyb21faGFzaGVzKHBnKTsKIAotCQlvcmRlciA9IGdldF9j
b3VudF9vcmRlcihwZy0+c2l6ZSAvIEVOVFJJRVNfUEVSX1BBR0UpOwotCQlpZiAob3JkZXIgPj0g
MCkKLQkJCWZyZWVfcGFnZXMoKHVuc2lnbmVkIGxvbmcpcGctPnJlY29yZHMsIG9yZGVyKTsKKwkJ
aWYgKHBnLT5yZWNvcmRzKSB7CisJCQlmcmVlX3BhZ2VzKCh1bnNpZ25lZCBsb25nKXBnLT5yZWNv
cmRzLCBwZy0+b3JkZXIpOworCQkJZnRyYWNlX251bWJlcl9vZl9wYWdlcyAtPSAxIDw8IHBnLT5v
cmRlcjsKKwkJfQogCQl0bXBfcGFnZSA9IHBnLT5uZXh0OwogCQlrZnJlZShwZyk7Ci0JCWZ0cmFj
ZV9udW1iZXJfb2ZfcGFnZXMgLT0gMSA8PCBvcmRlcjsKIAkJZnRyYWNlX251bWJlcl9vZl9ncm91
cHMtLTsKIAl9CiB9CkBAIC02Nzc0LDcgKzY3NzQsNiBAQCB2b2lkIGZ0cmFjZV9mcmVlX21lbShz
dHJ1Y3QgbW9kdWxlICptb2QsIHZvaWQgKnN0YXJ0X3B0ciwgdm9pZCAqZW5kX3B0cikKIAlzdHJ1
Y3QgZnRyYWNlX21vZF9tYXAgKm1vZF9tYXAgPSBOVUxMOwogCXN0cnVjdCBmdHJhY2VfaW5pdF9m
dW5jICpmdW5jLCAqZnVuY19uZXh0OwogCXN0cnVjdCBsaXN0X2hlYWQgY2xlYXJfaGFzaDsKLQlp
bnQgb3JkZXI7CiAKIAlJTklUX0xJU1RfSEVBRCgmY2xlYXJfaGFzaCk7CiAKQEAgLTY4MTIsMTAg
KzY4MTEsMTAgQEAgdm9pZCBmdHJhY2VfZnJlZV9tZW0oc3RydWN0IG1vZHVsZSAqbW9kLCB2b2lk
ICpzdGFydF9wdHIsIHZvaWQgKmVuZF9wdHIpCiAJCWZ0cmFjZV91cGRhdGVfdG90X2NudC0tOwog
CQlpZiAoIXBnLT5pbmRleCkgewogCQkJKmxhc3RfcGcgPSBwZy0+bmV4dDsKLQkJCW9yZGVyID0g
Z2V0X2NvdW50X29yZGVyKHBnLT5zaXplIC8gRU5UUklFU19QRVJfUEFHRSk7Ci0JCQlpZiAob3Jk
ZXIgPj0gMCkKLQkJCQlmcmVlX3BhZ2VzKCh1bnNpZ25lZCBsb25nKXBnLT5yZWNvcmRzLCBvcmRl
cik7Ci0JCQlmdHJhY2VfbnVtYmVyX29mX3BhZ2VzIC09IDEgPDwgb3JkZXI7CisJCQlpZiAocGct
PnJlY29yZHMpIHsKKwkJCQlmcmVlX3BhZ2VzKCh1bnNpZ25lZCBsb25nKXBnLT5yZWNvcmRzLCBw
Zy0+b3JkZXIpOworCQkJCWZ0cmFjZV9udW1iZXJfb2ZfcGFnZXMgLT0gMSA8PCBwZy0+b3JkZXI7
CisJCQl9CiAJCQlmdHJhY2VfbnVtYmVyX29mX2dyb3Vwcy0tOwogCQkJa2ZyZWUocGcpOwogCQkJ
cGcgPSBjb250YWluZXJfb2YobGFzdF9wZywgc3RydWN0IGZ0cmFjZV9wYWdlLCBuZXh0KTsK
--0000000000001ed4c905bed8efba--
