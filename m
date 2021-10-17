Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A40430C3A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 23:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344630AbhJQVGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 17:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344632AbhJQVFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 17:05:34 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2060C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 14:03:23 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id i22so257945ual.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=xgMy3v5fiH33vmXzvZ7bTPIBl7tmJv6i6HxsL2A985s=;
        b=k9RnKzBk+kzR9dsl/cKPxPwOxMVfyPd+U0Q0x5DknN04VHfxpMzRklshmEI2bx3zF2
         kAUnnZwX9oq3ppKdiBbo4nXVM1apoS47LEqWbwZ1pmXkI9UvrwUmVVlYoQc4C3INtYG1
         4fXFooCLF9WsPM14nylcOBRhnTOEzOUy+LEUUCjsMKNkCBXGr+F2gd5jDqM+TzH1pECI
         SoA4LA0zmdVm1brmwuck1gDVvcQ0w7OGrx+ZOXgA6c1I646Zb0DhEtv5TVj2cO+zckdu
         QRXE+1jYk/1otpyz+5Sc6wmqihOcypea0oEEda8MM2I5uwDQBpew9i9YoR+/Vi0zNj5K
         ZAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=xgMy3v5fiH33vmXzvZ7bTPIBl7tmJv6i6HxsL2A985s=;
        b=DH3s3d2yBQ04ayb4jYoSOheqtkCyPq43ozOa8E5Arqqjfk6aO6zOmz0EJcw+qkFwTS
         QFWpkPC7hh/FTkqCg3tCj/nakIh1rYYSe9e/bZXpjoNrMBCRt8DMZP+vpAcCXVfHE2AE
         aw13y6ISw6ySWQYWBFkCoM5vVBMJMlsZdzsvqE2MhvIq0PyPnryHbp5IscnTyKqp0021
         5ZX5rLE6668mEAdfTmJSr+7cJzRqGMzJwQugKQjnQyHRtm9k/0stWl4RQEQTZYx6tR+0
         mm8R87PueSoexukhleLzNwPNh+vCaJAA4vCMzqTRHyuJqCq3Sa87ikftjWLcXc83HDpl
         CUmQ==
X-Gm-Message-State: AOAM533LnAIMd15k4+kFu89n2XJecAFEdeIuH8hl92jLP9u2VqpvrqMu
        7WSJ3j8/LoTcP5Ak4CSXdBw=
X-Google-Smtp-Source: ABdhPJzP8oFwN4ON7+aNEG5+IjUKbPK5WiZXpCT50eJOMLEZb0tG4s2TrJ1AQOnCDRqaLcBBsFAvmg==
X-Received: by 2002:a67:d504:: with SMTP id l4mr24363760vsj.42.1634504602936;
        Sun, 17 Oct 2021 14:03:22 -0700 (PDT)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m11sm8311866vkp.46.2021.10.17.14.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 14:03:22 -0700 (PDT)
Date:   Sun, 17 Oct 2021 18:03:21 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf evsel: Fix missing exclude_{host,guest} setting
User-Agent: K-9 Mail for Android
In-Reply-To: <YWx0CgTyyZ4sm/l4@krava>
References: <20211016051253.2035821-1-namhyung@kernel.org> <YWx0CgTyyZ4sm/l4@krava>
Message-ID: <E4C04539-9803-4405-A1EA-5D9517682E08@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 17, 2021 4:05:46 PM GMT-03:00, Jiri Olsa <jolsa@redhat=2Ecom> w=
rote:
>On Fri, Oct 15, 2021 at 10:12:53PM -0700, Namhyung Kim wrote:
>> The current logic for the perf missing feature has a bug that it can
>> wrongly clear some modifiers like G or H=2E  Actually some PMUs don't
>> support any filtering or exclusion while others do=2E  But we check it
>> as a global feature=2E
>>=20
>> For example, the cycles event can have 'G' modifier to enable it only
>> in the guest mode on x86=2E  When you don't run any VMs it'll return 0=
=2E
>>=20
>>   # perf stat -a -e cycles:G sleep 1
>>=20
>>     Performance counter stats for 'system wide':
>>=20
>>                     0      cycles:G
>>=20
>>           1=2E000721670 seconds time elapsed
>>=20
>> But when it's used with other pmu events that don't support G modifier,
>> it'll be reset and return non-zero values=2E
>>=20
>>   # perf stat -a -e cycles:G,msr/tsc/ sleep 1
>>=20
>>     Performance counter stats for 'system wide':
>>=20
>>           538,029,960      cycles:G
>>        16,924,010,738      msr/tsc/
>>=20
>>           1=2E001815327 seconds time elapsed
>>=20
>> This is because of the missing feature detection logic being global=2E
>> Add a hashmap to set pmu-specific exclude_host/guest features=2E
>>=20
>> Reported-by: Stephane Eranian <eranian@google=2Ecom>
>> Signed-off-by: Namhyung Kim <namhyung@kernel=2Eorg>
>> ---
>>  tools/perf/util/evsel=2Ec | 47 +++++++++++++++++++++++++++++++++++----=
--
>>  tools/perf/util/evsel=2Eh |  6 ++++++
>>  2 files changed, 47 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/tools/perf/util/evsel=2Ec b/tools/perf/util/evsel=2Ec
>> index dbfeceb2546c=2E=2E437a28e769fe 100644
>> --- a/tools/perf/util/evsel=2Ec
>> +++ b/tools/perf/util/evsel=2Ec
>> @@ -1434,6 +1434,10 @@ void evsel__delete(struct evsel *evsel)
>>  {
>>  	evsel__exit(evsel);
>>  	free(evsel);
>> +
>> +	/* just free it for the first evsel */
>> +	hashmap__free(perf_missing_features=2Epmu);
>> +	perf_missing_features=2Epmu =3D NULL;
>>  }
>> =20
>>  void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
>> @@ -1791,6 +1795,23 @@ static int __evsel__prepare_open(struct evsel *e=
vsel, struct perf_cpu_map *cpus,
>>  	return 0;
>>  }
>> =20
>> +#define PMU_HASH_BITS  4
>> +
>> +static size_t pmu_hash(const void *key, void *ctx __maybe_unused)
>> +{
>> +	const struct evsel *evsel =3D key;
>> +
>> +	return hash_bits(evsel->core=2Eattr=2Etype, PMU_HASH_BITS);
>> +}
>> +
>> +static bool pmu_equal(const void *key1, const void *key2, void *ctx __=
maybe_unused)
>> +{
>> +	const struct evsel *a =3D key1;
>> +	const struct evsel *b =3D key2;
>> +
>> +	return a->core=2Eattr=2Etype =3D=3D b->core=2Eattr=2Etype;
>> +}
>> +
>>  static void evsel__disable_missing_features(struct evsel *evsel)
>>  {
>>  	if (perf_missing_features=2Eweight_struct) {
>> @@ -1807,8 +1828,14 @@ static void evsel__disable_missing_features(stru=
ct evsel *evsel)
>>  		evsel->open_flags &=3D ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
>>  	if (perf_missing_features=2Emmap2)
>>  		evsel->core=2Eattr=2Emmap2 =3D 0;
>> -	if (perf_missing_features=2Eexclude_guest)
>> -		evsel->core=2Eattr=2Eexclude_guest =3D evsel->core=2Eattr=2Eexclude_=
host =3D 0;
>> +	if (perf_missing_features=2Eexclude_guest) {
>> +		void *pmu;
>
>could you just pass NULL in here instead of NULL?

ENOPARSE=20

>
>> +
>> +		if (hashmap__find(perf_missing_features=2Epmu, evsel, &pmu)) {
>> +			evsel->core=2Eattr=2Eexclude_guest =3D 0;
>> +			evsel->core=2Eattr=2Eexclude_host =3D 0;
>> +		}
>> +	}
>>  	if (perf_missing_features=2Elbr_flags)
>>  		evsel->core=2Eattr=2Ebranch_sample_type &=3D ~(PERF_SAMPLE_BRANCH_NO=
_FLAGS |
>>  				     PERF_SAMPLE_BRANCH_NO_CYCLES);
>> @@ -1840,6 +1867,9 @@ int evsel__prepare_open(struct evsel *evsel, stru=
ct perf_cpu_map *cpus,
>> =20
>>  bool evsel__detect_missing_features(struct evsel *evsel)
>>  {
>> +	if (perf_missing_features=2Epmu =3D=3D NULL)
>> +		perf_missing_features=2Epmu =3D hashmap__new(pmu_hash, pmu_equal, NU=
LL);
>> +
>>  	/*
>>  	 * Must probe features in the order they were added to the
>>  	 * perf_event_attr interface=2E
>> @@ -1900,10 +1930,15 @@ bool evsel__detect_missing_features(struct evse=
l *evsel)
>>  		perf_missing_features=2Emmap2 =3D true;
>>  		pr_debug2_peo("switching off mmap2\n");
>>  		return true;
>> -	} else if (!perf_missing_features=2Eexclude_guest &&
>> -		   (evsel->core=2Eattr=2Eexclude_guest || evsel->core=2Eattr=2Eexclu=
de_host)) {
>> -		perf_missing_features=2Eexclude_guest =3D true;
>> -		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
>> +	} else if ((evsel->core=2Eattr=2Eexclude_guest || evsel->core=2Eattr=
=2Eexclude_host) &&
>> +		   !hashmap__find(perf_missing_features=2Epmu, evsel, NULL)) {
>> +		struct perf_missing_pmu_features pmu_features =3D { true };
>
>missing new line after declaration
>
>> +		hashmap__add(perf_missing_features=2Epmu, evsel, &pmu_features);
>> +
>> +		if (!perf_missing_features=2Eexclude_guest) {
>> +			perf_missing_features=2Eexclude_guest =3D true;
>> +			pr_debug2_peo("switching off exclude_guest, exclude_host\n");
>> +		}
>>  		return true;
>>  	} else if (!perf_missing_features=2Esample_id_all) {
>>  		perf_missing_features=2Esample_id_all =3D true;
>> diff --git a/tools/perf/util/evsel=2Eh b/tools/perf/util/evsel=2Eh
>> index 1f7edfa8568a=2E=2E8dd11c8e022d 100644
>> --- a/tools/perf/util/evsel=2Eh
>> +++ b/tools/perf/util/evsel=2Eh
>> @@ -172,6 +172,12 @@ struct perf_missing_features {
>>  	bool data_page_size;
>>  	bool code_page_size;
>>  	bool weight_struct;
>> +
>> +	struct hashmap *pmu;
>> +};
>> +
>> +struct perf_missing_pmu_features {
>> +	bool exclude_guest;
>>  };
>
>hum, is this really needed? I think you could just pass '1' as value,
>because you care only if the item is hashed, right?
>
>in any case the value is the current stack address of the
>  struct perf_missing_pmu_features pmu_features =3D { true };
>
>so it might as well be just '1' =2E=2E=2E I was confused at the beggining
>and looked for the reason of this struct ;-)
>
>we do that already in util/stat=2Ec
>
>jirka
>
>> =20
>>  extern struct perf_missing_features perf_missing_features;
>> --=20
>> 2=2E33=2E0=2E1079=2Eg6e70778dc9-goog
>>=20
>
