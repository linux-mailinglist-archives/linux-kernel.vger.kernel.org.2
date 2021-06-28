Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F473B6AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 00:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhF1WRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 18:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhF1WRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 18:17:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C8FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 15:15:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h1-20020a255f410000b02905585436b530so3420438ybm.21
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 15:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4i0VkToPNF6XLWlUgK6OtMxoTpqCliT486ch+IhMSdg=;
        b=QNqMqE1B5qqiRDLkYEO8JC97qinunKPmuO4oWlzb1LLr7kOf90mvnufWzk5OBLWn1C
         II4nitLcGEaWiiREbLAjoLpvcOTBEqGiC9W1h16iAQBQOAYQBf5a0xX9Gh0VOOkAnMoR
         oZUpglBguYh+KmDWgenPx/Dx8fBuTLT/So8q7q3Lqa9L6tAtNmyBOzmdhA4LRk9+/iK9
         s3Zc0gaGpS/4uz6rQQAdRpkDq0eHTpaPOIBJ+vXbzhm1NUTdOvaip7cGKoAFucflSYQi
         LaOeOSpozaPyCSOgz5huqK9s8SuX1Vgp/jrOwzB9cHLbfo4gDvu3kecm55cKZ9aTwlov
         mhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4i0VkToPNF6XLWlUgK6OtMxoTpqCliT486ch+IhMSdg=;
        b=XUbdR+qS2U1YJV+dYXcthtHhvKZCGvnyhugdlcOdTcJqiGybA6urjThjEkTsVXlqFE
         RHaqzC/gkh+d+2qUGjllx32F8NVJfkYYPID50Tp0NRIY9jYO6dscZtic9aPdXizqbXQm
         4S2FuzZtBDKRXB4GN0FD4nR2J5LvfmZfWesAlvWDSWvG5uPLr68LpwN8E850kjYwvIfz
         jMGdYGKXgl38opb4t4loomfkUmregDLGpnB5tA/OiP4nMzbm7y9fiP4u+10ATZyIhPGC
         0ZmEE6w/8I3bFqAn5WWR+EUL8MFeJO/JPBgyO7klk0921gZyBKzPstRDv85/oYmPTLL2
         LuOQ==
X-Gm-Message-State: AOAM530QfeTZNU4uviSpxdAoS3b0uaJ+05Mp997lwDZaJ5ksErH2ftaj
        I4krUTjm8lQsT5cavIIPyyfP3TZsPuPfLSYHSKFF
X-Google-Smtp-Source: ABdhPJy/H0hMC7gitYMZVZV4kidkM8SLL/aCdTVRg7N8zQf2b2fWkm/ClC9In0Lc/ZxNkr+bKQzhd2DFv/6qU/cGecgi
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c461:839b:7f72:359c])
 (user=axelrasmussen job=sendgmr) by 2002:a25:aea1:: with SMTP id
 b33mr34537384ybj.455.1624918501188; Mon, 28 Jun 2021 15:15:01 -0700 (PDT)
Date:   Mon, 28 Jun 2021 15:14:54 -0700
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
Message-Id: <20210628221454.651942-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210407014502.24091-1-michel@lespinasse.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: Re: [RFC PATCH 00/37] Speculative page faults
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, I'm (ab?)using `git send-email` to reply to this thread, so apologies in
advance if I've messed up and the mail gets mangled in some way.

Here are some results comparing the "pft" microbenchmark from mmtests, running
on "large-ish" machines: one with a Skylake CPU, one with a Rome CPU. These
results are comparing Linus' v5.12 tag versus a 5.12 base with Michel's SPF
patchset.

The tests were run with the following mmtests configuration:

export PFT_ITERATIONS=30
export PFT_MAPPING_SIZE=$((MEMTOTAL_BYTES/5))
export PFT_MIN_CLIENTS=1
export PFT_MAX_CLIENTS=$NUMCPUS
export PFT_USE_PROCESSES=no
export PFT_PAGESIZES=base

To explain the result formatting a bit:

Higher numbers are better (so +% means a performance improvement vs. the v5.12
base kernel).

To be explicit about the output format: our internal testing framework parses
the output of pft, and generates this comparison table for the A/B test. In
pft's raw output, the columns are as follows:

- Gigabytes of RAM used
- Number of threads
- Number of cachelines
- User time
- Sys time
- Elapsed time
- Faults per sec per CPU
- Faults per sec

So the metrics in the test report, are called "pft_faults_{cpu,sec}_#". These
are aggregating the rows of output from the pft test:

- "cpu" means the result is faults per sec per CPU
- "sec' means the result is faults per sec
- The number corresponds to the "number of threads" column.

Note that pft runs the test multiple times for each threadcount. So, each row in
these reports is an aggregation of all of those runs for a particular thread
count.

To summarize the results:

On the Skylake machine the SPF patchset seems to provide a scalability
improvement across the board. With a small # of threads, the SPF patchset
outperforms the v5.12 base. As the number of threads grows, the gap diverges,
with SPF beating baseline by a larger and larger %.

On the Rome machine, however, SPF outperforms baseline with small numbers of
threads, but as the threadcount increases they *converge*. Eventually (between
79 and 110 threads), baseline wins out, and SPF actually gives us *less*
performance. I don't really have a clear explanation for this.



Okay, with all that said, here are the results:

Host: 2x Intel Skylake CPU, 28 cores / 56 threads each = 56 cores / 112 threads, 192 GiB RAM

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
Kernel File: upstream-5-12.tar.xz

+-----------------+
| TEST KERNEL (B) |
+-----------------+
Kernel File: spf-5-12.tar.xz


[*] TAGS
             LABEL             |     VALUE
-------------------------------+-----------------
  kernel_version               | 5.12.0-smp-DEV
  kernel_version_major         | 5
  kernel_version_minor         | 12
  machine_platform_arch        | X86_64
  machine_platform_genus       | skylake
  machine_total_logical_cores  | 112
  machine_total_physical_cores | 56
  machine_total_ram_gib        | 192
  test_name                    | pft
  user                         | axelrasmussen

Note: values are delimited by colon (:)


[*] METRICS
        LABEL        | COUNT |       MIN       |       MAX        |          MEAN          |         MEDIAN         |       STDDEV       |   DIRECTION
---------------------+-------+-----------------+------------------+------------------------+------------------------+--------------------+----------------
  pft_faults_cpu_1   |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 565493.841      | 597051.859       | 574980.2721            | 570812.4335            | 8581.000516619562  |
  (B) b864a2166b52   | 30    | 564770.188      | 593162.85        | 582501.4053333333      | 587672.1510000001      | 10230.821799571824 |
                     |       | -0.13%          | -0.65%           | +1.31%                 | +2.95%                 | +19.23%            | <not defined>
  pft_faults_cpu_4   |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 511097.313      | 525778.068       | 519169.2665333333      | 518875.51300000004     | 3309.878510268415  |
  (B) b864a2166b52   | 30    | 522341.465      | 534768.283       | 528535.7364666668      | 529354.5875            | 2784.0796478571897 |
                     |       | +2.20%          | +1.71%           | +1.80%                 | +2.02%                 | -15.89%            | <not defined>
  pft_faults_cpu_7   |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 444047.293      | 477042.807       | 458029.40570000006     | 457146.5575            | 7141.073092774091  |
  (B) b864a2166b52   | 30    | 465624.007      | 501500.836       | 483791.1242666667      | 483134.7105            | 8256.428471156061  |
                     |       | +4.86%          | +5.13%           | +5.62%                 | +5.68%                 | +15.62%            | <not defined>
  pft_faults_cpu_12  |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 358661.222      | 434231.404       | 401799.73736666667     | 403513.576             | 18949.321891028267 |
  (B) b864a2166b52   | 30    | 418233.425      | 479956.806       | 451832.4433666666      | 455295.054             | 17026.783733301498 |
                     |       | +16.61%         | +10.53%          | +12.45%                | +12.83%                | -10.15%            | <not defined>
  pft_faults_cpu_21  |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 198339.171      | 258696.047       | 228804.68719999996     | 230395.9155            | 14085.607109196615 |
  (B) b864a2166b52   | 30    | 323446.812      | 384591.881       | 364176.7125666667      | 367052.1725            | 14414.08907027631  |
                     |       | +63.08%         | +48.67%          | +59.16%                | +59.31%                | +2.33%             | <not defined>
  pft_faults_cpu_30  |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 133771.268      | 162076.635       | 152097.81180000002     | 152233.40350000001     | 6269.9142812145465 |
  (B) b864a2166b52   | 30    | 179859.892      | 270190.89        | 243455.58066666668     | 242803.359             | 18445.098731373928 |
                     |       | +34.45%         | +66.71%          | +60.07%                | +59.49%                | +194.18%           | <not defined>
  pft_faults_cpu_48  |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 82579.061       | 104388.661       | 91568.5356333333       | 90592.1755             | 5546.777510223763  |
  (B) b864a2166b52   | 30    | 123542.341      | 171553.261       | 146579.92550000004     | 145360.7165            | 12601.231672937389 |
                     |       | +49.60%         | +64.34%          | +60.08%                | +60.46%                | +127.18%           | <not defined>
  pft_faults_cpu_79  |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 50894.891       | 59619.003        | 55129.4893             | 54661.8725             | 2458.8216885069032 |
  (B) b864a2166b52   | 30    | 91927.332       | 120933.559       | 102996.35123333332     | 102243.0855            | 7074.060753404679  |
                     |       | +80.62%         | +102.84%         | +86.83%                | +87.05%                | +187.70%           | <not defined>
  pft_faults_cpu_110 |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 31258.548       | 41685.942        | 36224.262500000004     | 36592.803              | 2680.4950001193283 |
  (B) b864a2166b52   | 30    | 74168.507       | 94616.572        | 82115.45999999999      | 81169.6525             | 4481.52286411527   |
                     |       | +137.27%        | +126.97%         | +126.69%               | +121.82%               | +67.19%            | <not defined>
  pft_faults_cpu_112 |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 31130.401       | 38908.904        | 35375.443100000004     | 35829.6035             | 2290.1349177377056 |
  (B) b864a2166b52   | 30    | 73258.73        | 92613.135        | 81351.41166666667      | 80899.55249999999      | 4220.631828597486  |
                     |       | +135.33%        | +138.03%         | +129.97%               | +125.79%               | +84.30%            | <not defined>
  pft_faults_sec_1   |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 564433.945      | 595277.365       | 573625.4990333333      | 569636.4879999999      | 8382.325888292982  |
  (B) b864a2166b52   | 30    | 563737.055      | 591576.036       | 580978.3862666666      | 586013.3670000001      | 9974.96387222383   |
                     |       | -0.12%          | -0.62%           | +1.28%                 | +2.87%                 | +19.00%            | <not defined>
  pft_faults_sec_4   |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 2.029701865e+06 | 2.089334274e+06  | 2.062801138933333e+06  | 2.059596098e+06        | 14075.442079268854 |
  (B) b864a2166b52   | 30    | 2.068478884e+06 | 2.12696578e+06   | 2.0998217110999995e+06 | 2.1048569074999997e+06 | 14703.254715627592 |
                     |       | +1.91%          | +1.80%           | +1.79%                 | +2.20%                 | +4.46%             | <not defined>
  pft_faults_sec_7   |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 3.072865342e+06 | 3.302000943e+06  | 3.169453882633334e+06  | 3.167175195e+06        | 50915.049503127535 |
  (B) b864a2166b52   | 30    | 3.123651261e+06 | 3.48522451e+06   | 3.3531759071666673e+06 | 3.351685131e+06        | 68012.57859696122  |
                     |       | +1.65%          | +5.55%           | +5.80%                 | +5.83%                 | +33.58%            | <not defined>
  pft_faults_sec_12  |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 4.215664312e+06 | 5.12743371e+06   | 4.703126739933333e+06  | 4.728185016e+06        | 240286.8825153738  |
  (B) b864a2166b52   | 30    | 4.968388093e+06 | 5.69411546e+06   | 5.359866512633331e+06  | 5.413731953e+06        | 207070.2801760229  |
                     |       | +17.86%         | +11.05%          | +13.96%                | +14.50%                | -13.82%            | <not defined>
  pft_faults_sec_21  |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 3.947870087e+06 | 5.151356879e+06  | 4.5692916812333325e+06 | 4.575656394e+06        | 287930.17681688163 |
  (B) b864a2166b52   | 30    | 6.631669322e+06 | 8.009437176e+06  | 7.552175649799999e+06  | 7.6175255265e+06       | 317684.09702681314 |
                     |       | +67.98%         | +55.48%          | +65.28%                | +66.48%                | +10.33%            | <not defined>
  pft_faults_sec_30  |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 3.789153013e+06 | 4.456429949e+06  | 4.1501704604999996e+06 | 4.139623102e+06        | 158198.37530642716 |
  (B) b864a2166b52   | 30    | 5.321981541e+06 | 7.794407019e+06  | 6.994074038533334e+06  | 7.011582908e+06        | 503444.05851691077 |
                     |       | +40.45%         | +74.90%          | +68.52%                | +69.38%                | +218.24%           | <not defined>
  pft_faults_sec_48  |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 3.496402856e+06 | 4.644547516e+06  | 3.820860616866667e+06  | 3.7869018389999997e+06 | 211076.70378028657 |
  (B) b864a2166b52   | 30    | 5.699219322e+06 | 7.20952334e+06   | 6.456858787866667e+06  | 6.41562651e+06         | 450973.69897164387 |
                     |       | +63.00%         | +55.23%          | +68.99%                | +69.42%                | +113.65%           | <not defined>
  pft_faults_sec_79  |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 3.479105285e+06 | 4.035012999e+06  | 3.7728950527e+06       | 3.730774097e+06        | 142408.19600171916 |
  (B) b864a2166b52   | 30    | 6.740820473e+06 | 8.557811658e+06  | 7.495920335099999e+06  | 7.4525865505e+06       | 458003.8944174562  |
                     |       | +93.75%         | +112.09%         | +98.68%                | +99.76%                | +221.61%           | <not defined>
  pft_faults_sec_110 |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 3.223198632e+06 | 4.134061429e+06  | 3.660475087133333e+06  | 3.7196672410000004e+06 | 250346.40765518686 |
  (B) b864a2166b52   | 30    | 7.766066553e+06 | 1.0045628577e+07 | 8.546153794033334e+06  | 8.481194604e+06        | 479152.6121881429  |
                     |       | +140.94%        | +143.00%         | +133.47%               | +128.01%               | +91.40%            | <not defined>
  pft_faults_sec_112 |       |                 |                  |                        |                        |                    |
  (A) 9f4ad9e425a1   | 30    | 3.208729058e+06 | 3.960855868e+06  | 3.627510960199999e+06  | 3.6704841215000004e+06 | 228364.6649597633  |
  (B) b864a2166b52   | 30    | 7.697393128e+06 | 9.643206206e+06  | 8.579052920500001e+06  | 8.4982216315e+06       | 429771.9693968675  |
                     |       | +139.89%        | +143.46%         | +136.50%               | +131.53%               | +88.20%            | <not defined>


============================================================================================================================================================


Host: 2x AMD Rome CPU, 64 cores / 128 threads each = 128 cores / 256 threads, 1 TiB RAM

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
Kernel File: upstream-5-12.tar.xz

+-----------------+
| TEST KERNEL (B) |
+-----------------+
Kernel File: spf-5-12.tar.xz


[*] TAGS
             LABEL             |     VALUE
-------------------------------+-----------------
  kernel_version               | 5.12.0-smp-DEV
  kernel_version_major         | 5
  kernel_version_minor         | 12
  machine_platform_arch        | X86_64
  machine_platform_genus       | rome
  machine_total_logical_cores  | 256
  machine_total_physical_cores | 128
  machine_total_ram_gib        | 1024
  test_name                    | pft
  user                         | axelrasmussen

Note: values are delimited by colon (:)


[*] METRICS
        LABEL        | COUNT |       MIN       |       MAX        |          MEAN          |         MEDIAN         |         STDDEV         |   DIRECTION
---------------------+-------+-----------------+------------------+------------------------+------------------------+------------------------+----------------
  pft_faults_cpu_1   |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 1.322299227e+06 | 1.350579319e+06  | 1.3360688650999998e+06 | 1.332799986e+06        | 8036.2199341743535     |
  (B) b864a2166b52   | 30    | 1.315533425e+06 | 1.335456188e+06  | 1.3275440968000002e+06 | 1.3296407555e+06       | 6298.976910285278      |
                     |       | -0.51%          | -1.12%           | -0.64%                 | -0.24%                 | -21.62%                | <not defined>
  pft_faults_cpu_4   |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 599753.078      | 835196.831       | 785973.1949666667      | 818552.9575            | 71177.98344956583      |
  (B) b864a2166b52   | 30    | 1.033135922e+06 | 1.069290557e+06  | 1.0482872088333336e+06 | 1.0468814775e+06       | 10779.7490408502       |
                     |       | +72.26%         | +28.03%          | +33.37%                | +27.89%                | -84.86%                | <not defined>
  pft_faults_cpu_7   |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 347767.594      | 582284.169       | 508009.3081            | 532618.8404999999      | 76179.64543982298      |
  (B) b864a2166b52   | 30    | 876652.745      | 963373.111       | 928708.5755333335      | 933480.6370000001      | 22305.420182136346     |
                     |       | +152.08%        | +65.45%          | +82.81%                | +75.26%                | -70.72%                | <not defined>
  pft_faults_cpu_12  |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 220799.208      | 305899.445       | 280923.0221            | 286852.4555            | 19497.416638332666     |
  (B) b864a2166b52   | 30    | 339602.001      | 531225.324       | 468710.86046666675     | 505322.6055            | 63089.14230805185      |
                     |       | +53.81%         | +73.66%          | +66.85%                | +76.16%                | +223.58%               | <not defined>
  pft_faults_cpu_21  |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 127237.472      | 213103.883       | 171006.9222            | 186122.27850000001     | 28325.93727251356      |
  (B) b864a2166b52   | 30    | 171981.459      | 239555.654       | 208386.11153333331     | 219433.95549999998     | 21608.36313357416      |
                     |       | +35.17%         | +12.41%          | +21.86%                | +17.90%                | -23.72%                | <not defined>
  pft_faults_cpu_30  |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 98673.026       | 217605.193       | 165832.00136666666     | 181021.78100000002     | 37277.826073472075     |
  (B) b864a2166b52   | 30    | 124005.714      | 221043.49        | 186948.93826666664     | 203430.498             | 28825.232853924826     |
                     |       | +25.67%         | +1.58%           | +12.73%                | +12.38%                | -22.67%                | <not defined>
  pft_faults_cpu_48  |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 88635.374       | 201202.155       | 164099.58250000002     | 178427.289             | 31615.465775759487     |
  (B) b864a2166b52   | 30    | 103850.066      | 198347.633       | 165546.73610000004     | 189675.25900000002     | 33104.97333224132      |
                     |       | +17.17%         | -1.42%           | +0.88%                 | +6.30%                 | +4.71%                 | <not defined>
  pft_faults_cpu_79  |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 81102.261       | 89112.314        | 83463.4302             | 83469.707              | 1869.7214449321116     |
  (B) b864a2166b52   | 30    | 83875.566       | 94160.682        | 91835.6409             | 92396.381              | 2578.3539781233358     |
                     |       | +3.42%          | +5.67%           | +10.03%                | +10.69%                | +37.90%                | <not defined>
  pft_faults_cpu_110 |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 77305.793       | 83501.445        | 81548.62710000001      | 81830.84099999999      | 1372.4842285878892     |
  (B) b864a2166b52   | 30    | 76212.241       | 78931.508        | 78123.50329999998      | 78462.183              | 762.927436545318       |
                     |       | -1.41%          | -5.47%           | -4.20%                 | -4.12%                 | -44.41%                | <not defined>
  pft_faults_cpu_128 |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 75343.922       | 82741.042        | 80366.33486666666      | 80530.75899999999      | 1430.3656765353558     |
  (B) b864a2166b52   | 30    | 72095.698       | 74123.908        | 73297.6984             | 73425.3245             | 571.842103541272       |
                     |       | -4.31%          | -10.41%          | -8.80%                 | -8.82%                 | -60.02%                | <not defined>
  pft_faults_sec_1   |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 1.317050628e+06 | 1.345243569e+06  | 1.3311298687999998e+06 | 1.3281300295000002e+06 | 8035.465831526684      |
  (B) b864a2166b52   | 30    | 1.311461655e+06 | 1.330935614e+06  | 1.3231212217333335e+06 | 1.3250745915e+06       | 6193.445975030056      |
                     |       | -0.42%          | -1.06%           | -0.60%                 | -0.23%                 | -22.92%                | <not defined>
  pft_faults_sec_4   |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 2.389687474e+06 | 3.327314892e+06  | 3.1228356446666666e+06 | 3.2612643784999996e+06 | 289852.17947539146     |
  (B) b864a2166b52   | 30    | 4.102518552e+06 | 4.250608035e+06  | 4.1639243518333333e+06 | 4.157235491e+06        | 41878.60201517858      |
                     |       | +71.68%         | +27.75%          | +33.34%                | +27.47%                | -85.55%                | <not defined>
  pft_faults_sec_7   |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 2.414012583e+06 | 4.032415905e+06  | 3.5188523367000003e+06 | 3.6881281375e+06       | 524652.8315124605      |
  (B) b864a2166b52   | 30    | 5.959160786e+06 | 6.580231542e+06  | 6.329055505566668e+06  | 6.3639131035e+06       | 147685.48556391377     |
                     |       | +146.86%        | +63.18%          | +79.86%                | +72.55%                | -71.85%                | <not defined>
  pft_faults_sec_12  |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 2.636643985e+06 | 3.648873092e+06  | 3.352667637600001e+06  | 3.4238721715e+06       | 231685.81558700278     |
  (B) b864a2166b52   | 30    | 3.95869994e+06  | 6.222621801e+06  | 5.5047526395666655e+06 | 5.925404714e+06        | 728923.8441016441      |
                     |       | +50.14%         | +70.54%          | +64.19%                | +73.06%                | +214.62%               | <not defined>
  pft_faults_sec_21  |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 2.659931432e+06 | 4.417172596e+06  | 3.5592916604333334e+06 | 3.8707699085e+06       | 581152.2296007784      |
  (B) b864a2166b52   | 30    | 3.550370032e+06 | 4.92603416e+06   | 4.2723118866e+06       | 4.490487737e+06        | 438423.4518313975      |
                     |       | +33.48%         | +11.52%          | +20.03%                | +16.01%                | -24.56%                | <not defined>
  pft_faults_sec_30  |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 2.946083199e+06 | 6.423331347e+06  | 4.914002587066667e+06  | 5.3587292535e+06       | 1.0898160729269844e+06 |
  (B) b864a2166b52   | 30    | 3.64123808e+06  | 6.532025228e+06  | 5.492737309800002e+06  | 5.97391926e+06         | 843563.7696236438      |
                     |       | +23.60%         | +1.69%           | +11.78%                | +11.48%                | -22.60%                | <not defined>
  pft_faults_sec_48  |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 4.214980049e+06 | 9.528581084e+06  | 7.7757277348e+06       | 8.448662988499999e+06  | 1.4883900190462691e+06 |
  (B) b864a2166b52   | 30    | 4.84579977e+06  | 9.330363688e+06  | 7.751113585633334e+06  | 8.8988808295e+06       | 1.5801553180324829e+06 |
                     |       | +14.97%         | -2.08%           | -0.32%                 | +5.33%                 | +6.17%                 | <not defined>
  pft_faults_sec_79  |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 6.348996215e+06 | 6.985977576e+06  | 6.533078342966668e+06  | 6.5315793925e+06       | 151519.46530198734     |
  (B) b864a2166b52   | 30    | 6.484637033e+06 | 7.169593031e+06  | 6.984747101799999e+06  | 7.004222881e+06        | 164329.43630222118     |
                     |       | +2.14%          | +2.63%           | +6.91%                 | +7.24%                 | +8.45%                 | <not defined>
  pft_faults_sec_110 |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 7.880294448e+06 | 9.09788171e+06   | 8.874888452533334e+06  | 8.9250222115e+06       | 218417.912935066       |
  (B) b864a2166b52   | 30    | 7.887984615e+06 | 8.408191775e+06  | 8.3027231049666675e+06 | 8.3457714105e+06       | 104353.66169193448     |
                     |       | +0.10%          | -7.58%           | -6.45%                 | -6.49%                 | -52.22%                | <not defined>
  pft_faults_sec_128 |       |                 |                  |                        |                        |                        |
  (A) 9f4ad9e425a1   | 30    | 8.659779012e+06 | 1.0498137566e+07 | 1.01219317397e+07      | 1.0153906594999999e+07 | 329224.7320975063      |
  (B) b864a2166b52   | 30    | 8.906613971e+06 | 9.256002835e+06  | 9.113201005133333e+06  | 9.114904465e+06        | 96222.63922675727      |
                     |       | +2.85%          | -11.83%          | -9.97%                 | -10.23%                | -70.77%                | <not defined>


============================================================================================================================================================


CPU cache info (getconf -a | grep CACHE):

Rome:
LEVEL1_ICACHE_SIZE 32768
LEVEL1_ICACHE_ASSOC 8
LEVEL1_ICACHE_LINESIZE 64
LEVEL1_DCACHE_SIZE 32768
LEVEL1_DCACHE_ASSOC 8
LEVEL1_DCACHE_LINESIZE 64
LEVEL2_CACHE_SIZE 524288
LEVEL2_CACHE_ASSOC 8
LEVEL2_CACHE_LINESIZE 64
LEVEL3_CACHE_SIZE 268435456
LEVEL3_CACHE_ASSOC 0
LEVEL3_CACHE_LINESIZE 64
LEVEL4_CACHE_SIZE 0
LEVEL4_CACHE_ASSOC 0
LEVEL4_CACHE_LINESIZE 0

Skylake:
LEVEL1_ICACHE_SIZE 32768
LEVEL1_ICACHE_ASSOC 8
LEVEL1_ICACHE_LINESIZE 64
LEVEL1_DCACHE_SIZE 32768
LEVEL1_DCACHE_ASSOC 8
LEVEL1_DCACHE_LINESIZE 64
LEVEL2_CACHE_SIZE 1048576
LEVEL2_CACHE_ASSOC 16
LEVEL2_CACHE_LINESIZE 64
LEVEL3_CACHE_SIZE 40370176
LEVEL3_CACHE_ASSOC 11
LEVEL3_CACHE_LINESIZE 64
LEVEL4_CACHE_SIZE 0
LEVEL4_CACHE_ASSOC 0
LEVEL4_CACHE_LINESIZE 0
