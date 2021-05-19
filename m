Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5225388CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350889AbhESLbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhESLbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:31:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE2C06175F;
        Wed, 19 May 2021 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QyYk4gIBgAs0F9NX1dEjCn6RLkHuXZT/E5JadFRxuqI=; b=pTbh7F5gawHkjR+t2ckyXvct/2
        bJjeJoVH1wVh91YoNZokGI+mRE3KV3HH9HvxLFDXMyPhq0EXOaxJQ+Y935/LZVDDx69lyw20bP4AT
        mlkBoaq9Ti/om5LmuWK1r3mBTYcTyZEROU0j/jE+hQTTXMKkFAQhwezIivoGg1G3BwPBm7ov82+vD
        MbkgT+LyaZcJLRpkEIzgFFdoyiIigoqogYZlyp3P8c5ZEZF+bpRko3X7A22RR4aI8Db2w33ExD7P5
        HSskZtRiTQ0eR6Sk2dwNrbQsIhPcrZ5hej2JhNuajPHQ1v2L5rIAdIEhByJR0reAwK192OS3FbtlJ
        X6WhaRbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljKOs-003mKr-U6; Wed, 19 May 2021 11:30:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D7AB3001E1;
        Wed, 19 May 2021 13:30:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5205022068E57; Wed, 19 May 2021 13:30:05 +0200 (CEST)
Date:   Wed, 19 May 2021 13:30:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <YKT2vbluMgcu94M6@hirez.programming.kicks-ass.net>
References: <1621239831-5870-1-git-send-email-beata.michalska@arm.com>
 <1621239831-5870-3-git-send-email-beata.michalska@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621239831-5870-3-git-send-email-beata.michalska@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mostly style nits, since I read you're already looking at reworking this
due to other feedback, do with it what you like.

On Mon, May 17, 2021 at 09:23:50AM +0100, Beata Michalska wrote:
> @@ -1989,66 +1989,96 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
>  
>  	return true;
>  }

+ whitespace

> +/**
> + * Asym capacity bits
> + */
> +struct asym_cap_data {
> +	struct list_head link;
> +	unsigned long    capacity;
> +	struct cpumask   *cpu_mask;
> +};

+ whitespace

>  /*
> + * Set of available CPUs grouped by their corresponding capacities
> + * Each list entry contains a CPU mask reflecting CPUs that share the same
> + * capacity.
> + * The lifespan of data is unlimited.
>   */
> +static LIST_HEAD(asym_cap_list);
>  
> +/*
> + * Verify whether given CPU at a given topology level belongs to a sched domain
> + * that does span CPUs with different capacities.
> + * Provides sd_flags reflecting the asymmetry scope.
> + */
> +static inline int
> +asym_cpu_capacity_classify(struct sched_domain_topology_level *tl, int cpu)
> +{
> +	int sd_asym_flags = SD_ASYM_CPUCAPACITY | SD_ASYM_CPUCAPACITY_FULL;
> +	const struct cpumask *tl_mask = tl->mask(cpu);
> +	struct asym_cap_data *entry;
> +	int asym_cap_count = 0;
> +
> +	if (list_is_singular(&asym_cap_list))
> +		goto leave;
> +
> +	list_for_each_entry(entry, &asym_cap_list, link) {
> +		if (cpumask_intersects(tl_mask, entry->cpu_mask))
> +			++asym_cap_count;
> +		else
> +			sd_asym_flags &= ~SD_ASYM_CPUCAPACITY_FULL;
>  	}
> +	WARN_ON_ONCE(!asym_cap_count);
> +leave:
> +	return asym_cap_count > 1 ? sd_asym_flags : 0;
> +}
>  
>  

- whitespace

> +/*
> + * Build-up/update list of CPUs grouped by their capacities
> + */
> +static void asym_cpu_capacity_scan(const struct cpumask *cpu_map)
> +{
> +	struct asym_cap_data *entry, *next;
> +	int cpu;
>  
> +	if (!list_empty(&asym_cap_list))
> +		list_for_each_entry(entry, &asym_cap_list, link)
> +			cpumask_clear(entry->cpu_mask);

two nits:

 - the if() needs { } because while what follows is strictly a single
   statement, it is multi-line, so coding style requires { }.

 - the if() is strictly superfluous, if the list is empty the
   list_for_each_entry() iteration already doesn't do anything.

>  
> +	entry = list_first_entry_or_null(&asym_cap_list,
> +			struct asym_cap_data, link);

Please align line-breaks at the most nested (, vim can help you do this
with: set cino=(0:0, if you're using that other editor, I'm sure you can
convince it to align properly too :-)

>  
> +	for_each_cpu(cpu, cpu_map) {
> +		unsigned long capacity = arch_scale_cpu_capacity(cpu);
>  
> +		if (entry && capacity == entry->capacity)
> +			goto next;
>  
> +		list_for_each_entry(entry, &asym_cap_list, link)
> +			if (capacity == entry->capacity)
> +				goto next;

{ } again

> +
> +		entry = kzalloc(sizeof(*entry) + cpumask_size(), GFP_KERNEL);
> +		if (entry) {
> +			entry->capacity = capacity;
> +			entry->cpu_mask = (struct cpumask *)((char *)entry +
> +					   sizeof(*entry));

alignment again

> +			list_add(&entry->link, &asym_cap_list);
>  		}
> +		WARN_ONCE(!entry,
> +		    "Failed to allocate memory for capacity asymmetry detection\n");

alignment again

(also, eeew, if this lives, perhaps a find_asym_data(capacity) helper
might make it better:

		if (!entry || entry->capacity != capacity)
			entry = find_asym_data(capacity);
)

> +next:
> +		__cpumask_set_cpu(cpu, entry->cpu_mask);
>  	}
>  
> +	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
> +		if (cpumask_empty(entry->cpu_mask)) {
> +			list_del(&entry->link);
> +			kfree(entry);
> +		}
> +	}

See, this has { }

>  }
