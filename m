Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E14233C34B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhCORFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCORFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:05:20 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AACC06174A;
        Mon, 15 Mar 2021 10:05:19 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id s1so10007234ilh.12;
        Mon, 15 Mar 2021 10:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=39ZN48q0zUkDRD+hp0CCNdCm31Y57ajm8R/PL6qcfJE=;
        b=ocSmXidV5cs8FHV/J3NK2Mkoopfo7UMjqYqVQQtOnps04FDgF6+6SgehS7Isd5d42M
         LftBtoM3YoQgPTOWkaXLRYH88MhXn1B0AkO6A8XN5rcFf6BP3lhRTlmX8FtogqxfQFWm
         kTOJ0AN231PIvk3mOxRpLrdzagjx7pNojk7rijrwoFgwjwOvXDb0yU+jeXHypIDjdRlU
         SIA/b0ySxmTLBMPB+AFkx0k//NZ5bYv0zBxRMuB5SoxL5xFE9ZcA1y6meiIdy/46PIvU
         tHcuBvJSUYUcbcmN4/Fb1F2ivZJ98BOuEYxJxrD8AwQOPSm+QsNrQvRmxDVHqgQOQVqS
         QxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=39ZN48q0zUkDRD+hp0CCNdCm31Y57ajm8R/PL6qcfJE=;
        b=q6AP+H2W1LKWDD/oq203XdFPH1Mni+bNbVBL55xiB+BfPiNxBv4aKN1kdEw+4t1ypC
         k/2VFL3i08/A+mhmsRvTROM2QpdWpr2wBfdXcZYAQ0t0q9FWf4TkZLnjDtBpBOP/gEOX
         9oP4sMQr8hc+kJsgDH14vegOkvG+urKh3+yxoaNVa/m/FPuHvCpJcw5BlEjkoNJ8Cu+C
         zig19bgcZk91zPRq3IHPmzpChGoUA0YHe1Vz5uDK95VAIgDzLJlg+GEPp+eLhPHbNRKE
         wlDPnsEmvegx32/TDR/Aeh1kHe2FcJsUnbMUdHfMosgVw+X3qQOGJMG/K5OjtqLR6k97
         fkFw==
X-Gm-Message-State: AOAM531sSMtSfctVtTj0RPNVMcp3ABEN05H7Z6BDGdFm21iECTKHDVpp
        5pZv2J2Z7Qj8fDlHvqfzYz4F0qXMt/YjklOl8yA=
X-Google-Smtp-Source: ABdhPJx2aJ0Tjb/6gayEiFEkCrz+qmFV5JvDeHXTpZDtwHDSLmajOi2KyKLMhAPeTgxroKiUpaflv3MYXKTOZKyW1t0=
X-Received: by 2002:a92:ce84:: with SMTP id r4mr481941ilo.112.1615827919134;
 Mon, 15 Mar 2021 10:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210312113253.305040674@infradead.org> <20210312205914.GG22098@zn.tnic>
 <CA+icZUWSCS6vAQOXoG6nsW+Dbnogivzf+rmegCTMjz5hjE5cKQ@mail.gmail.com>
 <20210313084923.GA16144@zn.tnic> <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic> <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
 <20210313124919.GD16144@zn.tnic> <CA+icZUWXuknBMdxTQXjJH2JiOgZbWcbk1U=dk6Zp2FgygU5Nyg@mail.gmail.com>
 <20210313132927.GF16144@zn.tnic> <CA+icZUWTSo2vkQO_tRggDFvvF_Q6AdzhvhQvmAsNxKnpGXHi0Q@mail.gmail.com>
In-Reply-To: <CA+icZUWTSo2vkQO_tRggDFvvF_Q6AdzhvhQvmAsNxKnpGXHi0Q@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 15 Mar 2021 18:04:41 +0100
Message-ID: <CA+icZUXLyFqq0y_GnKca8MS4wO2kcj4K-D1kBHLa8u_pnLZ7eQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Content-Type: multipart/mixed; boundary="00000000000024158805bd964128"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000024158805bd964128
Content-Type: text/plain; charset="UTF-8"

On Sat, Mar 13, 2021 at 2:47 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
[ ... ]
> Let me look if I will do a selfmade ThinLTO+PGO optimized LLVM
> toolchain v12.0.0-rc3 this weekend.
>

I did it.

Here some fresh numbers:

[ Selfmade LLVM toolchain v12.0.0-rc3 "stage1-only" ]
[ Host-Kernel: 5.12.0-rc2-8-amd64-clang12-cfi includes Peter's NOPS patchset ]

Performance counter stats for 'make V=1 -j4 LLVM=1 LLVM_IAS=1
PAHOLE=/opt/pahole/bin/pahole LOCALVERSION=-9-amd64-clang12-cfi
KBUILD_VERBOSE=1 KBUILD_BUILD_HOST=iniza
KBUILD_BUILD_USER=sedat.dilek@gmail.com
KBUILD_BUILD_TIMESTAMP=2021-03-13 bindeb-pkg
KDEB_PKGVERSION=5.12.0~rc2-9~bullseye+dileks1':

      55936351.95 msec task-clock                #    3.580 CPUs
utilized
          8291848      context-switches          #    0.148 K/sec
           269686      cpu-migrations            #    0.005 K/sec
        288389721      page-faults               #    0.005 M/sec
  108344049253836      cycles                    #    1.937 GHz
   83228135285263      stalled-cycles-frontend   #   76.82% frontend
cycles idle
   65616255370809      stalled-cycles-backend    #   60.56% backend
cycles idle
   59590373937199      instructions              #    0.55  insn per
cycle
                                                 #    1.40  stalled
cycles per insn
   10906265495505      branches                  #  194.976 M/sec
     488578274434      branch-misses             #    4.48% of all
branches

  15622.926203302 seconds time elapsed

  53453.974928000 seconds user
   2526.773533000 seconds sys


[ Selfmade LLVM toolchain v12.0.0-rc3 "thinlto_pgo_optimized" ]
[ Host-Kernel: Debian's 5.10.19-1 kernel ]

Performance counter stats for 'make V=1 -j4 LLVM=1 LLVM_IAS=1
PAHOLE=/opt/pahole/bin/pahole LOCALVERSION=-10-amd64-clang12-cfi
KBUILD_VERBOSE=1 KBUILD_BUILD_HOST=iniza
KBUILD_BUILD_USER=sedat.dilek@gmail.com
KBUILD_BUILD_TIMESTAMP=2021-03-14 bindeb-pkg
KDEB_PKGVERSION=5.12.0~rc2-10~bullseye+dileks1':

      40223080.69 msec task-clock                #    3.434 CPUs
utilized
          7438923      context-switches          #    0.185 K/sec
           245636      cpu-migrations            #    0.006 K/sec
        288073015      page-faults               #    0.007 M/sec
   77325441657129      cycles                    #    1.922 GHz
   55357463522675      stalled-cycles-frontend   #   71.59% frontend
cycles idle
   38978871249074      stalled-cycles-backend    #   50.41% backend
cycles idle
   55178265045056      instructions              #    0.71  insn per
cycle
                                                 #    1.00  stalled
cycles per insn
    9749166033571      branches                  #  242.377 M/sec
     431303563167      branch-misses             #    4.42% of all
branches

  11714.751645982 seconds time elapsed

  37951.117840000 seconds user
   2313.807151000 seconds sys


[ Selfmade LLVM toolchain v12.0.0-rc3 "thinlto_pgo_optimized" ]
[ Host-Kernel: 5.12.0-rc2-10-amd64-clang12-cfi includes Peter's NOPS patchset ]

Performance counter stats for 'make V=1 -j4 LLVM=1 LLVM_IAS=1
PAHOLE=/opt/pahole/bin/pahole LOCALVERSION=-1-amd64-clang12-cfi
KBUILD_VERBOSE=1 KBUILD_BUILD_HOST=iniza
KBUILD_BUILD_USER=sedat.dilek@gmail.com
KBUILD_BUILD_TIMESTAMP=2021-03-15 bindeb-pkg
KDEB_PKGVERSION=5.12.0~rc3-1~bullseye+dileks1':

      40632207.25 msec task-clock                #    3.406 CPUs
utilized
          8216832      context-switches          #    0.202 K/sec
           277610      cpu-migrations            #    0.007 K/sec
        281331052      page-faults               #    0.007 M/sec
   77031538570411      cycles                    #    1.896 GHz
              (83.33%)
   55247905369487      stalled-cycles-frontend   #   71.72% frontend
cycles idle     (83.33%)
   39046795510242      stalled-cycles-backend    #   50.69% backend
cycles idle      (66.67%)
   54592585444704      instructions              #    0.71  insn per
cycle
                                                 #    1.01  stalled
cycles per insn  (83.33%)
    9641589406714      branches                  #  237.289 M/sec
              (83.33%)
     435317273069      branch-misses             #    4.51% of all
branches          (83.33%)

  11928.047003788 seconds time elapsed

  38187.685111000 seconds user
   2502.075987000 seconds sys

As said in an earlier email:
A ThinLTO+PGO optimized LLVM-toolchain saves here approx. 60mins of build-time.

Depending on the host-kernel including Peter's NOPS patchset: 3mins
longer build-time.
Brewing time of one single Turkish Tea bag.

Attached are the 3 build-time log-files.

- Sedat -

--00000000000024158805bd964128
Content-Type: text/plain; charset="US-ASCII"; 
	name="build-time_5.12.0-rc2-9-amd64-clang12-cfi.txt"
Content-Disposition: attachment; 
	filename="build-time_5.12.0-rc2-9-amd64-clang12-cfi.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kmau1j8y0>
X-Attachment-Id: f_kmau1j8y0

IFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdtYWtlIFY9MSAtajQgTExWTT0xIExMVk1f
SUFTPTEgUEFIT0xFPS9vcHQvcGFob2xlL2Jpbi9wYWhvbGUgTE9DQUxWRVJTSU9OPS05LWFtZDY0
LWNsYW5nMTItY2ZpIEtCVUlMRF9WRVJCT1NFPTEgS0JVSUxEX0JVSUxEX0hPU1Q9aW5pemEgS0JV
SUxEX0JVSUxEX1VTRVI9c2VkYXQuZGlsZWtAZ21haWwuY29tIEtCVUlMRF9CVUlMRF9USU1FU1RB
TVA9MjAyMS0wMy0xMyBiaW5kZWItcGtnIEtERUJfUEtHVkVSU0lPTj01LjEyLjB+cmMyLTl+YnVs
bHNleWUrZGlsZWtzMSc6CgogICAgICAgNTU5MzYzNTEuOTUgbXNlYyB0YXNrLWNsb2NrICAgICAg
ICAgICAgICAgICMgICAgMy41ODAgQ1BVcyB1dGlsaXplZCAgICAgICAgICAKICAgICAgICAgICA4
MjkxODQ4ICAgICAgY29udGV4dC1zd2l0Y2hlcyAgICAgICAgICAjICAgIDAuMTQ4IEsvc2VjICAg
ICAgICAgICAgICAgICAgCiAgICAgICAgICAgIDI2OTY4NiAgICAgIGNwdS1taWdyYXRpb25zICAg
ICAgICAgICAgIyAgICAwLjAwNSBLL3NlYyAgICAgICAgICAgICAgICAgIAogICAgICAgICAyODgz
ODk3MjEgICAgICBwYWdlLWZhdWx0cyAgICAgICAgICAgICAgICMgICAgMC4wMDUgTS9zZWMgICAg
ICAgICAgICAgICAgICAKICAgMTA4MzQ0MDQ5MjUzODM2ICAgICAgY3ljbGVzICAgICAgICAgICAg
ICAgICAgICAjICAgIDEuOTM3IEdIeiAgICAgICAgICAgICAgICAgICAgCiAgICA4MzIyODEzNTI4
NTI2MyAgICAgIHN0YWxsZWQtY3ljbGVzLWZyb250ZW5kICAgIyAgIDc2LjgyJSBmcm9udGVuZCBj
eWNsZXMgaWRsZSAgIAogICAgNjU2MTYyNTUzNzA4MDkgICAgICBzdGFsbGVkLWN5Y2xlcy1iYWNr
ZW5kICAgICMgICA2MC41NiUgYmFja2VuZCBjeWNsZXMgaWRsZSAgICAKICAgIDU5NTkwMzczOTM3
MTk5ICAgICAgaW5zdHJ1Y3Rpb25zICAgICAgICAgICAgICAjICAgIDAuNTUgIGluc24gcGVyIGN5
Y2xlICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIyAgICAxLjQwICBzdGFsbGVkIGN5Y2xlcyBwZXIgaW5zbgogICAgMTA5MDYyNjU0OTU1
MDUgICAgICBicmFuY2hlcyAgICAgICAgICAgICAgICAgICMgIDE5NC45NzYgTS9zZWMgICAgICAg
ICAgICAgICAgICAKICAgICAgNDg4NTc4Mjc0NDM0ICAgICAgYnJhbmNoLW1pc3NlcyAgICAgICAg
ICAgICAjICAgIDQuNDglIG9mIGFsbCBicmFuY2hlcyAgICAgICAgCgogICAxNTYyMi45MjYyMDMz
MDIgc2Vjb25kcyB0aW1lIGVsYXBzZWQKCiAgIDUzNDUzLjk3NDkyODAwMCBzZWNvbmRzIHVzZXIK
ICAgIDI1MjYuNzczNTMzMDAwIHNlY29uZHMgc3lzCgoK
--00000000000024158805bd964128
Content-Type: text/plain; charset="US-ASCII"; 
	name="build-time_5.12.0-rc2-10-amd64-clang12-cfi.txt"
Content-Disposition: attachment; 
	filename="build-time_5.12.0-rc2-10-amd64-clang12-cfi.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kmau1mn71>
X-Attachment-Id: f_kmau1mn71

IFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdtYWtlIFY9MSAtajQgTExWTT0xIExMVk1f
SUFTPTEgUEFIT0xFPS9vcHQvcGFob2xlL2Jpbi9wYWhvbGUgTE9DQUxWRVJTSU9OPS0xMC1hbWQ2
NC1jbGFuZzEyLWNmaSBLQlVJTERfVkVSQk9TRT0xIEtCVUlMRF9CVUlMRF9IT1NUPWluaXphIEtC
VUlMRF9CVUlMRF9VU0VSPXNlZGF0LmRpbGVrQGdtYWlsLmNvbSBLQlVJTERfQlVJTERfVElNRVNU
QU1QPTIwMjEtMDMtMTQgYmluZGViLXBrZyBLREVCX1BLR1ZFUlNJT049NS4xMi4wfnJjMi0xMH5i
dWxsc2V5ZStkaWxla3MxJzoKCiAgICAgICA0MDIyMzA4MC42OSBtc2VjIHRhc2stY2xvY2sgICAg
ICAgICAgICAgICAgIyAgICAzLjQzNCBDUFVzIHV0aWxpemVkICAgICAgICAgIAogICAgICAgICAg
IDc0Mzg5MjMgICAgICBjb250ZXh0LXN3aXRjaGVzICAgICAgICAgICMgICAgMC4xODUgSy9zZWMg
ICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgMjQ1NjM2ICAgICAgY3B1LW1pZ3JhdGlvbnMg
ICAgICAgICAgICAjICAgIDAuMDA2IEsvc2VjICAgICAgICAgICAgICAgICAgCiAgICAgICAgIDI4
ODA3MzAxNSAgICAgIHBhZ2UtZmF1bHRzICAgICAgICAgICAgICAgIyAgICAwLjAwNyBNL3NlYyAg
ICAgICAgICAgICAgICAgIAogICAgNzczMjU0NDE2NTcxMjkgICAgICBjeWNsZXMgICAgICAgICAg
ICAgICAgICAgICMgICAgMS45MjIgR0h6ICAgICAgICAgICAgICAgICAgICAKICAgIDU1MzU3NDYz
NTIyNjc1ICAgICAgc3RhbGxlZC1jeWNsZXMtZnJvbnRlbmQgICAjICAgNzEuNTklIGZyb250ZW5k
IGN5Y2xlcyBpZGxlICAgCiAgICAzODk3ODg3MTI0OTA3NCAgICAgIHN0YWxsZWQtY3ljbGVzLWJh
Y2tlbmQgICAgIyAgIDUwLjQxJSBiYWNrZW5kIGN5Y2xlcyBpZGxlICAgIAogICAgNTUxNzgyNjUw
NDUwNTYgICAgICBpbnN0cnVjdGlvbnMgICAgICAgICAgICAgICMgICAgMC43MSAgaW5zbiBwZXIg
Y3ljbGUgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAjICAgIDEuMDAgIHN0YWxsZWQgY3ljbGVzIHBlciBpbnNuCiAgICAgOTc0OTE2NjAz
MzU3MSAgICAgIGJyYW5jaGVzICAgICAgICAgICAgICAgICAgIyAgMjQyLjM3NyBNL3NlYyAgICAg
ICAgICAgICAgICAgIAogICAgICA0MzEzMDM1NjMxNjcgICAgICBicmFuY2gtbWlzc2VzICAgICAg
ICAgICAgICMgICAgNC40MiUgb2YgYWxsIGJyYW5jaGVzICAgICAgICAKCiAgIDExNzE0Ljc1MTY0
NTk4MiBzZWNvbmRzIHRpbWUgZWxhcHNlZAoKICAgMzc5NTEuMTE3ODQwMDAwIHNlY29uZHMgdXNl
cgogICAgMjMxMy44MDcxNTEwMDAgc2Vjb25kcyBzeXMKCgo=
--00000000000024158805bd964128
Content-Type: text/plain; charset="US-ASCII"; 
	name="build-time_5.12.0-rc3-1-amd64-clang12-cfi.txt"
Content-Disposition: attachment; 
	filename="build-time_5.12.0-rc3-1-amd64-clang12-cfi.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kmau1qab2>
X-Attachment-Id: f_kmau1qab2

IFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdtYWtlIFY9MSAtajQgTExWTT0xIExMVk1f
SUFTPTEgUEFIT0xFPS9vcHQvcGFob2xlL2Jpbi9wYWhvbGUgTE9DQUxWRVJTSU9OPS0xLWFtZDY0
LWNsYW5nMTItY2ZpIEtCVUlMRF9WRVJCT1NFPTEgS0JVSUxEX0JVSUxEX0hPU1Q9aW5pemEgS0JV
SUxEX0JVSUxEX1VTRVI9c2VkYXQuZGlsZWtAZ21haWwuY29tIEtCVUlMRF9CVUlMRF9USU1FU1RB
TVA9MjAyMS0wMy0xNSBiaW5kZWItcGtnIEtERUJfUEtHVkVSU0lPTj01LjEyLjB+cmMzLTF+YnVs
bHNleWUrZGlsZWtzMSc6CgogICAgICAgNDA2MzIyMDcuMjUgbXNlYyB0YXNrLWNsb2NrICAgICAg
ICAgICAgICAgICMgICAgMy40MDYgQ1BVcyB1dGlsaXplZCAgICAgICAgICAKICAgICAgICAgICA4
MjE2ODMyICAgICAgY29udGV4dC1zd2l0Y2hlcyAgICAgICAgICAjICAgIDAuMjAyIEsvc2VjICAg
ICAgICAgICAgICAgICAgCiAgICAgICAgICAgIDI3NzYxMCAgICAgIGNwdS1taWdyYXRpb25zICAg
ICAgICAgICAgIyAgICAwLjAwNyBLL3NlYyAgICAgICAgICAgICAgICAgIAogICAgICAgICAyODEz
MzEwNTIgICAgICBwYWdlLWZhdWx0cyAgICAgICAgICAgICAgICMgICAgMC4wMDcgTS9zZWMgICAg
ICAgICAgICAgICAgICAKICAgIDc3MDMxNTM4NTcwNDExICAgICAgY3ljbGVzICAgICAgICAgICAg
ICAgICAgICAjICAgIDEuODk2IEdIeiAgICAgICAgICAgICAgICAgICAgICAoODMuMzMlKQogICAg
NTUyNDc5MDUzNjk0ODcgICAgICBzdGFsbGVkLWN5Y2xlcy1mcm9udGVuZCAgICMgICA3MS43MiUg
ZnJvbnRlbmQgY3ljbGVzIGlkbGUgICAgICg4My4zMyUpCiAgICAzOTA0Njc5NTUxMDI0MiAgICAg
IHN0YWxsZWQtY3ljbGVzLWJhY2tlbmQgICAgIyAgIDUwLjY5JSBiYWNrZW5kIGN5Y2xlcyBpZGxl
ICAgICAgKDY2LjY3JSkKICAgIDU0NTkyNTg1NDQ0NzA0ICAgICAgaW5zdHJ1Y3Rpb25zICAgICAg
ICAgICAgICAjICAgIDAuNzEgIGluc24gcGVyIGN5Y2xlICAgICAgICAgCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyAgICAxLjAxICBzdGFsbGVkIGN5
Y2xlcyBwZXIgaW5zbiAgKDgzLjMzJSkKICAgICA5NjQxNTg5NDA2NzE0ICAgICAgYnJhbmNoZXMg
ICAgICAgICAgICAgICAgICAjICAyMzcuMjg5IE0vc2VjICAgICAgICAgICAgICAgICAgICAoODMu
MzMlKQogICAgICA0MzUzMTcyNzMwNjkgICAgICBicmFuY2gtbWlzc2VzICAgICAgICAgICAgICMg
ICAgNC41MSUgb2YgYWxsIGJyYW5jaGVzICAgICAgICAgICg4My4zMyUpCgogICAxMTkyOC4wNDcw
MDM3ODggc2Vjb25kcyB0aW1lIGVsYXBzZWQKCiAgIDM4MTg3LjY4NTExMTAwMCBzZWNvbmRzIHVz
ZXIKICAgIDI1MDIuMDc1OTg3MDAwIHNlY29uZHMgc3lzCgoK
--00000000000024158805bd964128--
