Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC74139C110
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhFDUPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229791AbhFDUPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622837594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17vjbzt5yO7rpMCYk+AkX2vrC/BT8XUvRzQmEjVhtp8=;
        b=UhjTb5lQFjvM8iuZktJtSaeNYOrqOhvehhGbUefMgdCettQD+tr8AlkItDe0uofrL2aoFg
        Hr2/eh6AYOroSwgkGAhSykQBSethBawbUkqdeNoGais0z0CpPfF8hiB/5b5Spc1D4Eiz1x
        frqQadcaDj/N2Ou8m+NsUpxyy8mH9gA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-T6E_vgi3PKadja67dN0PmQ-1; Fri, 04 Jun 2021 16:13:13 -0400
X-MC-Unique: T6E_vgi3PKadja67dN0PmQ-1
Received: by mail-ed1-f70.google.com with SMTP id c12-20020aa7d60c0000b029038fccdf4390so5572374edr.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 13:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=17vjbzt5yO7rpMCYk+AkX2vrC/BT8XUvRzQmEjVhtp8=;
        b=c+4N8yHoD7M/bsEeq98pFzauIMwB6IHRwm22JNRczAIephYFBwXf8zIp2nUXVlJL3H
         mnFQZ68eHxvXN+KVA4BDfHv2Hq42Njwk7NuvSFutgbE1Cbv8vRH4GHW6LDPYkiK9b66T
         zjmqC5HxseBhd4kt5acc0Hu1F3qL1xsfNZ6NLlhMAhBXsk6wpkiTVI4JvvU68EMzPCE8
         TyZRnSVQHhFjQjdDrew9SnPzhpcrUrwrnmuHHPp/xTA0t/IxHPjD9W2fd54+m6k9SVyh
         +jP4Fzt3Gcn41Zsyx/W7Y8pDV1T0p9Npz/31UCxPpnOtQmztM9SApnJ72RE5vIHZjDEi
         n8HQ==
X-Gm-Message-State: AOAM531/5QUqCiWXsdGAd3DVlNQWSmvD99uvwZ28CmfqOGFqrTjHEn/3
        OuppXGr2MFxDK4dSOsm4/WqZnWgzIlun30tCLkeCS3Tqibt/OuhmvLv1ffK/S7luO7f590FXQse
        NBf5afT6/sNG+wKTtd/gcZHdSFGrbNyaUtoHGdiH2CBMtO9cD2DPqlQdjkyB2zkonseFSJa/gA6
        6/
X-Received: by 2002:a17:906:c0da:: with SMTP id bn26mr5937238ejb.437.1622837591859;
        Fri, 04 Jun 2021 13:13:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8dwjC71UuNAO5+zcObJ610Nc47paYqmLNSUD3pWGdn0xIAcf+XqWw+6LK3igG4DrdBr2IyA==
X-Received: by 2002:a17:906:c0da:: with SMTP id bn26mr5937212ejb.437.1622837591453;
        Fri, 04 Jun 2021 13:13:11 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f18sm3192583ejz.119.2021.06.04.13.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 13:13:11 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] platform/surface: aggregator: Allow enabling of
 events without notifiers
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210604134755.535590-1-luzmaximilian@gmail.com>
 <20210604134755.535590-3-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <44e65839-0ee5-98d3-20dd-edfc40f6818e@redhat.com>
Date:   Fri, 4 Jun 2021 22:13:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604134755.535590-3-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/4/21 3:47 PM, Maximilian Luz wrote:
> We can already enable and disable SAM events via one of two ways: either
> via a (non-observer) notifier tied to a specific event group, or a
> generic event enable/disable request. In some instances, however,
> neither method may be desirable.
> 
> The first method will tie the event enable request to a specific
> notifier, however, when we want to receive notifications for multiple
> event groups of the same target category and forward this to the same
> notifier callback, we may receive duplicate events, i.e. one event per
> registered notifier. The second method will bypass the internal
> reference counting mechanism, meaning that a disable request will
> disable the event regardless of any other client driver using it, which
> may break the functionality of that driver.
> 
> To address this problem, add new functions that allow enabling and
> disabling of events via the event reference counting mechanism built
> into the controller, without needing to register a notifier.
> 
> This can then be used in combination with observer notifiers to process
> multiple events of the same target category without duplication in the
> same callback function.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
> 
> Changes in v2:
>  - Remove unused variable
>  - Avoid code duplication
> 
> ---
>  .../platform/surface/aggregator/controller.c  | 293 +++++++++++++++---
>  include/linux/surface_aggregator/controller.h |   8 +
>  2 files changed, 253 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
> index cd3a6b77f48d..c673aa8309c8 100644
> --- a/drivers/platform/surface/aggregator/controller.c
> +++ b/drivers/platform/surface/aggregator/controller.c
> @@ -407,6 +407,31 @@ ssam_nf_refcount_dec(struct ssam_nf *nf, struct ssam_event_registry reg,
>  	return NULL;
>  }
>  
> +/**
> + * ssam_nf_refcount_dec_free() - Decrement reference-/activation-count of the
> + * given event and free its entry if the reference count reaches zero.
> + * @nf:  The notifier system reference.
> + * @reg: The registry used to enable/disable the event.
> + * @id:  The event ID.
> + *
> + * Decrements the reference-/activation-count of the specified event, freeing
> + * its entry if it reaches zero.
> + *
> + * Note: ``nf->lock`` must be held when calling this function.
> + */
> +static void ssam_nf_refcount_dec_free(struct ssam_nf *nf,
> +				      struct ssam_event_registry reg,
> +				      struct ssam_event_id id)
> +{
> +	struct ssam_nf_refcount_entry *entry;
> +
> +	lockdep_assert_held(&nf->lock);
> +
> +	entry = ssam_nf_refcount_dec(nf, reg, id);
> +	if (entry && entry->refcount == 0)
> +		kfree(entry);
> +}
> +
>  /**
>   * ssam_nf_refcount_empty() - Test if the notification system has any
>   * enabled/active events.
> @@ -2122,6 +2147,109 @@ int ssam_ctrl_notif_d0_entry(struct ssam_controller *ctrl)
>  
>  /* -- Top-level event registry interface. ----------------------------------- */
>  
> +/**
> + * ssam_nf_refcount_enable() - Enable event for reference count entry if it has
> + * not already been enabled.
> + * @ctrl:  The controller to enable the event on.
> + * @entry: The reference count entry for the event to be enabled.
> + * @flags: The flags used for enabling the event on the EC.
> + *
> + * Enable the event associated with the given reference count entry if the
> + * reference count equals one, i.e. the event has not previously been enabled.
> + * If the event has already been enabled (i.e. reference count not equal to
> + * one), check that the flags used for enabling match and warn about this if
> + * they do not.
> + *
> + * This does not modify the reference count itself, which is done with
> + * ssam_nf_refcount_inc() / ssam_nf_refcount_dec().
> + *
> + * Note: ``nf->lock`` must be held when calling this function.
> + *
> + * Return: Returns zero on success. If the event is enabled by this call,
> + * returns the status of the event-enable EC command.
> + */
> +static int ssam_nf_refcount_enable(struct ssam_controller *ctrl,
> +				   struct ssam_nf_refcount_entry *entry, u8 flags)
> +{
> +	const struct ssam_event_registry reg = entry->key.reg;
> +	const struct ssam_event_id id = entry->key.id;
> +	struct ssam_nf *nf = &ctrl->cplt.event.notif;
> +	int status;
> +
> +	lockdep_assert_held(&nf->lock);
> +
> +	ssam_dbg(ctrl, "enabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
> +		 reg.target_category, id.target_category, id.instance, entry->refcount);
> +
> +	if (entry->refcount == 1) {
> +		status = ssam_ssh_event_enable(ctrl, reg, id, flags);
> +		if (status)
> +			return status;
> +
> +		entry->flags = flags;
> +
> +	} else if (entry->flags != flags) {
> +		ssam_warn(ctrl,
> +			  "inconsistent flags when enabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
> +			  flags, entry->flags, reg.target_category, id.target_category,
> +			  id.instance);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ssam_nf_refcount_enable() - Disable event for reference count entry if it is

s/ssam_nf_refcount_enable/ssam_nf_refcount_disable_free/

No need to resend, I'll fix this up when merging this series.

Regards,

Hans




> + * no longer in use and free the corresponding entry.
> + * @ctrl:  The controller to disable the event on.
> + * @entry: The reference count entry for the event to be disabled.
> + * @flags: The flags used for enabling the event on the EC.
> + *
> + * If the reference count equals zero, i.e. the event is no longer requested by
> + * any client, the event will be disabled and the corresponding reference count
> + * entry freed. The reference count entry must not be used any more after a
> + * call to this function.
> + *
> + * Also checks if the flags used for disabling the event match the flags used
> + * for enabling the event and warns if they do not (regardless of reference
> + * count).
> + *
> + * This does not modify the reference count itself, which is done with
> + * ssam_nf_refcount_inc() / ssam_nf_refcount_dec().
> + *
> + * Note: ``nf->lock`` must be held when calling this function.
> + *
> + * Return: Returns zero on success. If the event is disabled by this call,
> + * returns the status of the event-enable EC command.
> + */
> +static int ssam_nf_refcount_disable_free(struct ssam_controller *ctrl,
> +					 struct ssam_nf_refcount_entry *entry, u8 flags)
> +{
> +	const struct ssam_event_registry reg = entry->key.reg;
> +	const struct ssam_event_id id = entry->key.id;
> +	struct ssam_nf *nf = &ctrl->cplt.event.notif;
> +	int status;
> +
> +	lockdep_assert_held(&nf->lock);
> +
> +	ssam_dbg(ctrl, "disabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
> +		 reg.target_category, id.target_category, id.instance, entry->refcount);
> +
> +	if (entry->flags != flags) {
> +		ssam_warn(ctrl,
> +			  "inconsistent flags when disabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
> +			  flags, entry->flags, reg.target_category, id.target_category,
> +			  id.instance);
> +	}
> +
> +	if (entry->refcount == 0) {
> +		status = ssam_ssh_event_disable(ctrl, reg, id, flags);
> +		kfree(entry);
> +	}
> +
> +	return status;
> +}
> +
>  /**
>   * ssam_notifier_register() - Register an event notifier.
>   * @ctrl: The controller to register the notifier on.
> @@ -2166,41 +2294,26 @@ int ssam_notifier_register(struct ssam_controller *ctrl, struct ssam_event_notif
>  			mutex_unlock(&nf->lock);
>  			return PTR_ERR(entry);
>  		}
> -
> -		ssam_dbg(ctrl, "enabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
> -			 n->event.reg.target_category, n->event.id.target_category,
> -			 n->event.id.instance, entry->refcount);
>  	}
>  
>  	status = ssam_nfblk_insert(nf_head, &n->base);
>  	if (status) {
> -		if (entry) {
> -			entry = ssam_nf_refcount_dec(nf, n->event.reg, n->event.id);
> -			if (entry->refcount == 0)
> -				kfree(entry);
> -		}
> +		if (entry)
> +			ssam_nf_refcount_dec_free(nf, n->event.reg, n->event.id);
>  
>  		mutex_unlock(&nf->lock);
>  		return status;
>  	}
>  
> -	if (entry && entry->refcount == 1) {
> -		status = ssam_ssh_event_enable(ctrl, n->event.reg, n->event.id, n->event.flags);
> +	if (entry) {
> +		status = ssam_nf_refcount_enable(ctrl, entry, n->event.flags);
>  		if (status) {
>  			ssam_nfblk_remove(&n->base);
> -			kfree(ssam_nf_refcount_dec(nf, n->event.reg, n->event.id));
> +			ssam_nf_refcount_dec_free(nf, n->event.reg, n->event.id);
>  			mutex_unlock(&nf->lock);
>  			synchronize_srcu(&nf_head->srcu);
>  			return status;
>  		}
> -
> -		entry->flags = n->event.flags;
> -
> -	} else if (entry && entry->flags != n->event.flags) {
> -		ssam_warn(ctrl,
> -			  "inconsistent flags when enabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
> -			  n->event.flags, entry->flags, n->event.reg.target_category,
> -			  n->event.id.target_category, n->event.id.instance);
>  	}
>  
>  	mutex_unlock(&nf->lock);
> @@ -2247,35 +2360,20 @@ int ssam_notifier_unregister(struct ssam_controller *ctrl, struct ssam_event_not
>  	 * If this is an observer notifier, do not attempt to disable the
>  	 * event, just remove it.
>  	 */
> -	if (n->flags & SSAM_EVENT_NOTIFIER_OBSERVER)
> -		goto remove;
> -
> -	entry = ssam_nf_refcount_dec(nf, n->event.reg, n->event.id);
> -	if (WARN_ON(!entry)) {
> -		/*
> -		 * If this does not return an entry, there's a logic error
> -		 * somewhere: The notifier block is registered, but the event
> -		 * refcount entry is not there. Remove the notifier block
> -		 * anyways.
> -		 */
> -		status = -ENOENT;
> -		goto remove;
> -	}
> -
> -	ssam_dbg(ctrl, "disabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
> -		 n->event.reg.target_category, n->event.id.target_category,
> -		 n->event.id.instance, entry->refcount);
> -
> -	if (entry->flags != n->event.flags) {
> -		ssam_warn(ctrl,
> -			  "inconsistent flags when disabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
> -			  n->event.flags, entry->flags, n->event.reg.target_category,
> -			  n->event.id.target_category, n->event.id.instance);
> -	}
> +	if (!(n->flags & SSAM_EVENT_NOTIFIER_OBSERVER)) {
> +		entry = ssam_nf_refcount_dec(nf, n->event.reg, n->event.id);
> +		if (WARN_ON(!entry)) {
> +			/*
> +			 * If this does not return an entry, there's a logic
> +			 * error somewhere: The notifier block is registered,
> +			 * but the event refcount entry is not there. Remove
> +			 * the notifier block anyways.
> +			 */
> +			status = -ENOENT;
> +			goto remove;
> +		}
>  
> -	if (entry->refcount == 0) {
> -		status = ssam_ssh_event_disable(ctrl, n->event.reg, n->event.id, n->event.flags);
> -		kfree(entry);
> +		status = ssam_nf_refcount_disable_free(ctrl, entry, n->event.flags);
>  	}
>  
>  remove:
> @@ -2287,6 +2385,105 @@ int ssam_notifier_unregister(struct ssam_controller *ctrl, struct ssam_event_not
>  }
>  EXPORT_SYMBOL_GPL(ssam_notifier_unregister);
>  
> +/**
> + * ssam_controller_event_enable() - Enable the specified event.
> + * @ctrl:  The controller to enable the event for.
> + * @reg:   The event registry to use for enabling the event.
> + * @id:    The event ID specifying the event to be enabled.
> + * @flags: The SAM event flags used for enabling the event.
> + *
> + * Increment the event reference count of the specified event. If the event has
> + * not been enabled previously, it will be enabled by this call.
> + *
> + * Note: In general, ssam_notifier_register() with a non-observer notifier
> + * should be preferred for enabling/disabling events, as this will guarantee
> + * proper ordering and event forwarding in case of errors during event
> + * enabling/disabling.
> + *
> + * Return: Returns zero on success, %-ENOSPC if the reference count for the
> + * specified event has reached its maximum, %-ENOMEM if the corresponding event
> + * entry could not be allocated. If this is the first time that this event has
> + * been enabled (i.e. the reference count was incremented from zero to one by
> + * this call), returns the status of the event-enable EC-command.
> + */
> +int ssam_controller_event_enable(struct ssam_controller *ctrl,
> +				 struct ssam_event_registry reg,
> +				 struct ssam_event_id id, u8 flags)
> +{
> +	u16 rqid = ssh_tc_to_rqid(id.target_category);
> +	struct ssam_nf *nf = &ctrl->cplt.event.notif;
> +	struct ssam_nf_refcount_entry *entry;
> +	int status;
> +
> +	if (!ssh_rqid_is_event(rqid))
> +		return -EINVAL;
> +
> +	mutex_lock(&nf->lock);
> +
> +	entry = ssam_nf_refcount_inc(nf, reg, id);
> +	if (IS_ERR(entry)) {
> +		mutex_unlock(&nf->lock);
> +		return PTR_ERR(entry);
> +	}
> +
> +	status = ssam_nf_refcount_enable(ctrl, entry, flags);
> +	if (status) {
> +		ssam_nf_refcount_dec_free(nf, reg, id);
> +		mutex_unlock(&nf->lock);
> +		return status;
> +	}
> +
> +	mutex_unlock(&nf->lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ssam_controller_event_enable);
> +
> +/**
> + * ssam_controller_event_disable() - Disable the specified event.
> + * @ctrl:  The controller to disable the event for.
> + * @reg:   The event registry to use for disabling the event.
> + * @id:    The event ID specifying the event to be disabled.
> + * @flags: The flags used when enabling the event.
> + *
> + * Decrement the reference count of the specified event. If the reference count
> + * reaches zero, the event will be disabled.
> + *
> + * Note: In general, ssam_notifier_register()/ssam_notifier_unregister() with a
> + * non-observer notifier should be preferred for enabling/disabling events, as
> + * this will guarantee proper ordering and event forwarding in case of errors
> + * during event enabling/disabling.
> + *
> + * Return: Returns zero on success, %-ENOENT if the given event has not been
> + * enabled on the controller. If the reference count of the event reaches zero
> + * during this call, returns the status of the event-disable EC-command.
> + */
> +int ssam_controller_event_disable(struct ssam_controller *ctrl,
> +				  struct ssam_event_registry reg,
> +				  struct ssam_event_id id, u8 flags)
> +{
> +	u16 rqid = ssh_tc_to_rqid(id.target_category);
> +	struct ssam_nf *nf = &ctrl->cplt.event.notif;
> +	struct ssam_nf_refcount_entry *entry;
> +	int status = 0;
> +
> +	if (!ssh_rqid_is_event(rqid))
> +		return -EINVAL;
> +
> +	mutex_lock(&nf->lock);
> +
> +	entry = ssam_nf_refcount_dec(nf, reg, id);
> +	if (!entry) {
> +		mutex_unlock(&nf->lock);
> +		return -ENOENT;
> +	}
> +
> +	status = ssam_nf_refcount_disable_free(ctrl, entry, flags);
> +
> +	mutex_unlock(&nf->lock);
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(ssam_controller_event_disable);
> +
>  /**
>   * ssam_notifier_disable_registered() - Disable events for all registered
>   * notifiers.
> diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
> index cf4bb48a850e..7965bdc669c5 100644
> --- a/include/linux/surface_aggregator/controller.h
> +++ b/include/linux/surface_aggregator/controller.h
> @@ -838,4 +838,12 @@ int ssam_notifier_register(struct ssam_controller *ctrl,
>  int ssam_notifier_unregister(struct ssam_controller *ctrl,
>  			     struct ssam_event_notifier *n);
>  
> +int ssam_controller_event_enable(struct ssam_controller *ctrl,
> +				 struct ssam_event_registry reg,
> +				 struct ssam_event_id id, u8 flags);
> +
> +int ssam_controller_event_disable(struct ssam_controller *ctrl,
> +				  struct ssam_event_registry reg,
> +				  struct ssam_event_id id, u8 flags);
> +
>  #endif /* _LINUX_SURFACE_AGGREGATOR_CONTROLLER_H */
> 

