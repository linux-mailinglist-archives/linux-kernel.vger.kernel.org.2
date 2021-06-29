Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BC03B6E28
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhF2GRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhF2GRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:17:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED9F261DA6;
        Tue, 29 Jun 2021 06:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624947304;
        bh=UbVm3hNPdC/nxAkjpDLQrUcZww8TMViwqs/jhWa5o5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FuYyDFhvqCDpA/b87M0NDGnwncZGnCVxDmL7xW9gBfc7rTsGXvGDDeEFPtNBPAQuk
         nWKRubODdNekbVKeBEvtf7UEFff2BidgfU/9T4MCw90WIERty0vB1vochGXy64oNt1
         FahNUkw0N3PqneCI10+t0ByXBoz7qfuexWCkfm5c=
Date:   Tue, 29 Jun 2021 08:15:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com
Subject: Re: [PATCH V2 2/6] perf/x86/intel/uncore: Add alias PMU name
Message-ID: <YNq6ZqzHjQbV2ceN@kroah.com>
References: <1624911463-192936-1-git-send-email-kan.liang@linux.intel.com>
 <1624911463-192936-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624911463-192936-3-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 01:17:39PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A perf PMU may have two PMU names. For example, Intel Sapphire Rapids
> server supports the discovery mechanism. Without the platform-specific
> support, an uncore PMU is named by a type ID plus a box ID, e.g.,
> uncore_type_0_0, because the real name of the uncore PMU cannot be
> retrieved from the discovery table. With the platform-specific support
> later, perf has the mapping information from a type ID to a specific
> uncore unit. Just like the previous platforms, the uncore PMU is named
> by the real PMU name, e.g., uncore_cha_0. The user scripts which work
> well with the old numeric name may not work anymore.
> 
> Add a new attribute "alias" to indicate the old numeric name. The
> following userspace perf tool patch will handle both names. The user
> scripts should work properly with the updated perf tool.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: gregkh@linuxfoundation.org
> ---
>  .../testing/sysfs-bus-event_source-devices-uncore  | 13 ++++++++
>  arch/x86/events/intel/uncore.c                     | 19 ++++++++----
>  arch/x86/events/intel/uncore.h                     |  1 +
>  arch/x86/events/intel/uncore_snbep.c               | 35 +++++++++++++++++++++-
>  4 files changed, 61 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore b/Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore
> new file mode 100644
> index 0000000..b56e8f0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore
> @@ -0,0 +1,13 @@
> +What:		/sys/bus/event_source/devices/uncore_*/alias
> +Date:		June 2021
> +KernelVersion:	5.15
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:	Read-only.  An attribute to describe the alias name of
> +		the uncore PMU if an alias exists on some platforms.
> +		The 'perf(1)' tool should treat both names the same.
> +		They both can be used to access the uncore PMU.
> +
> +		Example:
> +
> +		$ cat /sys/devices/uncore_cha_2/alias
> +		uncore_type_0_2
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 7087ce7..ff07472 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -846,6 +846,18 @@ static const struct attribute_group uncore_pmu_attr_group = {
>  	.attrs = uncore_pmu_attrs,
>  };
>  
> +void uncore_get_alias_name(char *pmu_name, struct intel_uncore_pmu *pmu)
> +{
> +	struct intel_uncore_type *type = pmu->type;
> +
> +	if (type->num_boxes == 1)
> +		sprintf(pmu_name, "uncore_type_%u", type->type_id);
> +	else {
> +		sprintf(pmu_name, "uncore_type_%u_%d",
> +			type->type_id, type->box_ids[pmu->pmu_idx]);
> +	}
> +}
> +
>  static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
>  {
>  	struct intel_uncore_type *type = pmu->type;
> @@ -855,12 +867,7 @@ static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
>  	 * Use uncore_type_&typeid_&boxid as name.
>  	 */
>  	if (!type->name) {
> -		if (type->num_boxes == 1)
> -			sprintf(pmu->name, "uncore_type_%u", type->type_id);
> -		else {
> -			sprintf(pmu->name, "uncore_type_%u_%d",
> -				type->type_id, type->box_ids[pmu->pmu_idx]);
> -		}
> +		uncore_get_alias_name(pmu->name, pmu);
>  		return;
>  	}
>  
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index 6d44b7e..f65fb73 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -560,6 +560,7 @@ struct event_constraint *
>  uncore_get_constraint(struct intel_uncore_box *box, struct perf_event *event);
>  void uncore_put_constraint(struct intel_uncore_box *box, struct perf_event *event);
>  u64 uncore_shared_reg_config(struct intel_uncore_box *box, int idx);
> +void uncore_get_alias_name(char *pmu_name, struct intel_uncore_pmu *pmu);
>  
>  extern struct intel_uncore_type *empty_uncore[];
>  extern struct intel_uncore_type **uncore_msr_uncores;
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 44f2469..fc09ca4 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -5429,6 +5429,33 @@ static const struct attribute_group spr_uncore_chabox_format_group = {
>  	.attrs = spr_uncore_cha_formats_attr,
>  };
>  
> +static ssize_t alias_show(struct device *dev,
> +			  struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct intel_uncore_pmu *pmu = dev_to_uncore_pmu(dev);
> +	char pmu_name[UNCORE_PMU_NAME_LEN];
> +
> +	uncore_get_alias_name(pmu_name, pmu);
> +	return snprintf(buf, PAGE_SIZE, "%s\n", pmu_name);

Please use sysfs_emit() for new sysfs attributes.

> +}
> +
> +static DEVICE_ATTR_RO(alias);
> +
> +static struct attribute *uncore_alias_name_attrs[] = {
> +	&dev_attr_alias.attr,
> +	NULL
> +};
> +
> +static struct attribute_group uncore_alias_name = {
> +	.attrs			= uncore_alias_name_attrs,
> +};
> +
> +static const struct attribute_group *spr_uncore_attr_update[] = {
> +	&uncore_alias_name,
> +	NULL,
> +};

ATTRIBUTE_GROUPS()?

