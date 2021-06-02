Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A2C3987E6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhFBLU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230230AbhFBLU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622632754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PzygKPqG3eIp4YxcoQ8AkWGfrlImF+icCQT32sQ4Ges=;
        b=KCZhKhKvOwo/OgwK7CYeAXD92oUmStYsBVkJxZ83olQXSoN5PFOpu+/EjqG14o5pqem8ls
        owKI4yBKP7jEb7fQ0jgFm3LjfuuiChuqeH9BKeEGKhw3Udxldo9Ql/6xmBWLKWG5CCsDG9
        +1Y3RDwUqP4LTh+rI9aNiGkyoC7UOSQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-33yYk5RGO9CjVNw6vvHBlw-1; Wed, 02 Jun 2021 07:19:12 -0400
X-MC-Unique: 33yYk5RGO9CjVNw6vvHBlw-1
Received: by mail-ed1-f69.google.com with SMTP id w1-20020aa7da410000b029038d323eeee3so1209292eds.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 04:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PzygKPqG3eIp4YxcoQ8AkWGfrlImF+icCQT32sQ4Ges=;
        b=RA5pfxvk7i6+pb40aR7EhwcV7WMZzeHoxxl+c5Hi6/LM6Cr5o8fvqONBADFzFH8G7G
         A05O3Vb1PogkdQ4KToNVcg8TYOrjFdV/0x+kDFudrL9NHglEAqpEylSU9VnlxTpeLxpx
         FULo1krRKrUwS8++j0r7MiJrTrXD1thhG9DsTeGNIag1kumztuYcuyfuriaQskDA5A5A
         d0yP1rs229rI3m0W6f9E41MUiVYxIhtZv6F45vbOltTvaETly5dGC1dJHd+344vxmusi
         VKEehnaGNPAha3pNwWXJngthaY7AYcFAHaj+WRUiMMvxx1HJAJM1ufizOPL5SODnxI3j
         +eMg==
X-Gm-Message-State: AOAM530Z9c0WCQdwiujzeY2gqsiR+vEPMlXKnET3q4GDfL65NPh5IAvz
        Vg31TvvO5VwHcwwaRCz+URpQaGcAJsDx0izr1gt60EthKNJvFt1gXgP2e6REL5idLjtnP2tvouC
        Gx/BcHEVkfHMKSk7LGoWy8jmV
X-Received: by 2002:a05:6402:4406:: with SMTP id y6mr30300571eda.278.1622632751221;
        Wed, 02 Jun 2021 04:19:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjvh73C3SGLqkCzR3UozSxPNmGUjdf3X8A1BFCDvnBuV9M9mbdsXEeiK1pfm13iltIAnCrnQ==
X-Received: by 2002:a05:6402:4406:: with SMTP id y6mr30300547eda.278.1622632750976;
        Wed, 02 Jun 2021 04:19:10 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id dh18sm586770edb.92.2021.06.02.04.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 04:19:10 -0700 (PDT)
Subject: Re: [PATCH 1/1] ishtp: Add support for Intel ishtp eclite driver
To:     "K Naduvalath, Sumesh" <sumesh.k.naduvalath@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>
Cc:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chinnu, Ganapathi" <ganapathi.chinnu@intel.com>,
        "Kumar, Nachiketa" <nachiketa.kumar@intel.com>
References: <20210531120415.14480-1-sumesh.k.naduvalath@intel.com>
 <e28a9a7c-ec02-f71d-da6a-270f2dcbd58f@redhat.com>
 <BYAPR11MB37529B9B31E8188ABB29C683A93E9@BYAPR11MB3752.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1dbdb756-a87a-0ab6-4784-55e1edeb55d0@redhat.com>
Date:   Wed, 2 Jun 2021 13:19:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB37529B9B31E8188ABB29C683A93E9@BYAPR11MB3752.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumesh,

On 6/1/21 8:24 PM, K Naduvalath, Sumesh wrote:
> Thank you Hans for the review comments. Please find the reply inline -
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Monday, May 31, 2021 8:25 PM
>> To: K Naduvalath, Sumesh <sumesh.k.naduvalath@intel.com>;
>> mgross@linux.intel.com; srinivas.pandruvada@linux.intel.com
>> Cc: Pandruvada, Srinivas <srinivas.pandruvada@intel.com>; platform-driver-
>> x86@vger.kernel.org; linux-kernel@vger.kernel.org; Chinnu, Ganapathi
>> <ganapathi.chinnu@intel.com>; Kumar, Nachiketa
>> <nachiketa.kumar@intel.com>
>> Subject: Re: [PATCH 1/1] ishtp: Add support for Intel ishtp eclite driver
>>
>> Hi,
>>
>> Thank you, I've done a quick review, which has already spotted quite a few
>> issues. Note I will probably do a more thorough review later which mind find
>> more issues, but lets start with fixing the serious issues which this review has
>> found.

<snip>

>>> diff --git a/drivers/platform/x86/Kconfig
>>> b/drivers/platform/x86/Kconfig index 60592fb88e7a..cfa2cb150909 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -1180,6 +1180,19 @@ config INTEL_CHTDC_TI_PWRBTN
>>>  	  To compile this driver as a module, choose M here: the module
>>>  	  will be called intel_chtdc_ti_pwrbtn.
>>>
>>> +config INTEL_ISHTP_ECLITE
>>> +	tristate "Intel ISHTP eclite controller"
>>> +	depends on INTEL_ISH_HID
>>> +	depends on ACPI
>>> +	help
>>> +	  This driver is for accessing the PSE(Programmable Service Engine),
>>> +	  an Embedded Controller like IP, using ISHTP(Integratd Sensor Hub
>>> +	  Transport Protocol) to get battery, thermal and UCSI (USB Type-C
>>> +          Connector System Software Interface) related data from the
>> platform.
>>
>> This text has all the same issues as the commit message. Also please explain
>> on what sort of systems this functionality is typically found/used so that
>> users will have a better idea if this is something which they should enable on
>> their systems.
>>
> 
> This functionality is enabled for the first time for Intel's Elkhartlake platform.
> Users who don't want to use discrete Embedded Controller on their platform,
> they can leverage the integrated solution of ECLite which is part of 
> Elkhartlake's PSE subsystem. I'll add more text for the config item.

Thank you for the info.

<snip>

>>> +static acpi_status
>>> +ecl_opregion_cmd_handler(u32 function, acpi_physical_address address,
>>> +			 u32 bits, u64 *value64,
>>> +			 void *handler_context, void *region_context) {
>>> +	struct ishtp_opregion_dev *opr_dev;
>>> +	struct opregion_cmd *cmd;
>>> +
>>> +	if (!region_context || !value64)
>>> +		return AE_BAD_PARAMETER;
>>> +
>>> +	if (function == ACPI_READ)
>>> +		return AE_ERROR;
>>> +
>>> +	opr_dev = (struct ishtp_opregion_dev *)region_context;
>>> +	cmd = &opr_dev->opr_context.cmd_area;
>>
>> This is shared between all threads, we have had issues with sharing opregion
>> context between threads like this in the past.
>>
>> What is stopping ACPI code from trying to use the opr_context from multiple
>> threads at the same time, messing things up?
>>
> 
> This will not happen. BIOS calls ACPI methods (cmd and data in this driver) in a
> SERIALIZED manner. BIOS issues another call only after finishing the first one.

You say that this will not happen, but the problem which I have with the
OpRegion API is that this may actually very well happen. There are no
guarantees of this not happening. We are relying on the AML code from
the BIOS adding the "Serialized" attribute to all functions accessing the
OpRegion, all that is necessary is one bug in the AML code and then this
will happen.

And it is typically very hard to get vendors to issue BIOS updates to fix
things like this :|

I must honestly say that I find the whole design of the OpRegion API
lacking. There are other options to interface AML code, like e.g. modelling
the ISHTP as a generic serial bus, then a single OpRegion access can do the
following:

1. AML fills a buffer
2. OpRegion call processes buffer and writes back results (status code +
   data read if it is a read) to buffer
3. AML processes buffer

This is e.g. used in some Microsoft Surface 3 devices, see:
drivers/platform/surface/surface3_power.c

This would make the calls more-or-less atomic, removing the need for the
ACPI Methods to all be Serialized.

This would also allow the Opregion to return an error status code when
the EClite is not ready, instead of unregistering + reregistering the
OpRegion, which in itself is another source of possible races (see below).

I assume that it is too late to change the OpRegion API now, so that
we are stuck with this ?

I must say I'm disappointed about the quality of the OpRegion API design
here. APIs should be designed so that it is easy / natural to use them in
a correct way, where as this API seems to be dessgned in such a way that
it is easy to use it the wrong way.

I really expect Intel to do better the next time the introduce a new
OpRegion for something. It would help greatly if Intel would send some
rough sketches of how the API is going to look like to the mailinglist,
so that we can actually correct issues like these, rather then the API
already being set in stone and that we end up having to live with a
not so good API.

>> I'm especially worried about the offset + data_len used in various places,
>> even if we add checks for this, this could be changed underneath us by
>> another thread.
> 
> There are checks in BIOS for offset + data, but I'll add them in the driver as well.
> There is no other thread accessing it. Flow below -
> 
> ACPI method --> cmd --> 
> <--end ACPI method <-- 
> 
> <here no other ACPI method will execute because of serialized method>
> 
> ACPI method --> data--> 
> <--end ACPI method <-- 
> 
>>
>> You should add a mutex to the opr_dev and lock it in this function so that the
>> cmd struct cannot be changed underneath us while we are processing it.
>>
>> Note this does not fully protect against races like this:
>>
>> 1. Thread a sets offset
>> 2. Thread b sets a different offset
>> 3. Thread a writes ECL_ISH_READ to command.
> 
> These race conditions won't occur. No structure elements are used from two paths
> simultaneously. Only element from the opregion structure used outside ACPI path is 
> 
> opr_dev->dsm_event_id from event_work workqueque.
> 
> But this element not accessed from anywhere else including serialized ACPI path.

I understand that the intention is for all the ACPI calls to be serialized, but
nothing is guaranteeing this. All it requires is one method not being marked as
serialized...

>> This will result in thread a getting the data at the offset specified by thread b,
>> rather then at the offset which it requested. But there is nothing we can do
>> about that, that needs to be solved with synchronization at the AML level.
> 
> There is ASL serialization defined, But are you suggesting to put locks for the fairness
> of coding?

I don't want the kernel to read / write beyond the end of kernel-owned memory
because the following happens (this assumes one AML method is missing the Serialized
attribute):

1. #define ECL_DATA_OPR_BUFLEN	384
2. Thread A sets offset to 0
3. Thread A sets len to 100
4. Thread A writes ECL_ISH_WRITE
5. Thread A kernel checks (offset + len) < ECL_DATA_OPR_BUFLEN, this is ok
6. Thread B sets offset to 300
7. Thread A kernel does memcpy(message.payload, opr_dev->opr_context.data_area.data + message.header.offset, message.header.data_len);

7. Will now end up reading 100 bytes from offset 300 of opr_context.data_area.data,
which is only 384 bytes big, which needless to say is not good.
I see now that the offset + len are copied into message.header and then the copied
values are used. It is tempting to think that this thus can be fixed by doing a
check on the copied values, but the message struct is a local variable, so the
compiler will alias the 2 values and might decide to do the check on the originals;
and the compiler is also free to re-order things. So this making of a local copy
does not help.

This is a classic time-of-check vs time-of-use problem. Since we cannot _guarantee_
that all users of the OpRegion are properly using the ACPI Serialized Method attribute,
we need some other mechanism to ensure that len + offset do not change between
checking and consuming them. The most straight forward solution here is to
protect opr_context with a mutex so that it cannot be changed by another thread
while one call is in progress. Since all accesses should be serialized at the AML
level anyways this will not add extra serialization, while it will help avoid
AML bugs turning into out-of-bounds memory accesses inside the kernel.

<snip>

>>> +static acpi_status
>>> +ecl_opregion_data_handler(u32 function, acpi_physical_address address,
>>> +			  u32 bits, u64 *value64,
>>> +			  void *handler_context, void *region_context) {
>>> +	struct ishtp_opregion_dev *opr_dev;
>>> +	unsigned int bytes = BITS_TO_BYTES(bits);
>>> +	void *data_addr;
>>> +
>>> +	if (!region_context || !value64)
>>> +		return AE_BAD_PARAMETER;
>>> +
>>> +	if (address + bytes > ECL_DATA_OPR_BUFLEN)
>>> +		return AE_BAD_PARAMETER;
>>> +
>>> +	opr_dev = (struct ishtp_opregion_dev *)region_context;
>>> +	data_addr = &opr_dev->opr_context.data_area.data[address];
>>> +
>>> +	if (function == ACPI_READ)
>>> +		memcpy(value64, data_addr, bytes);
>>> +	else if (function == ACPI_WRITE)
>>> +		memcpy(data_addr, value64, bytes);
>>
>> What if bits is not a multiple of 8? Then we have just overwritten a bunch of
>> bits which the caller did not request us to do.
>>
>> Since the caller specifies bits, this should really do a read-modify-write of the
>> last byte when there are any "leftover" bits. ?  What does the
>> documentation say about this?
> 
> The request will always be multiple of 8 bits as per ASL definition/docs.

Ok.


>>> +	else
>>> +		return AE_BAD_PARAMETER;
>>> +
>>> +	return AE_OK;
>>> +}
>>> +
>>> +static int acpi_opregion_init(struct ishtp_opregion_dev *opr_dev) {
>>> +	acpi_status status;
>>> +	struct acpi_device *adev;
>>> +
>>> +	/* Find ECLite device and install opregion handlers */
>>> +	adev = acpi_dev_get_first_match_dev("INTC1035", NULL, -1);
>>> +	if (!adev) {
>>> +		dev_err(cl_data_to_dev(opr_dev), "eclite ACPI device not
>> found\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	opr_dev->acpi_handle = adev->handle;
>>
>> acpi_opregion_init() seem to get called on every resume, doing the lookup is
>> only necessary once, after that the cached value in opr_dev->acpi_handle
>> can be reused.
>>
>> More importantly this whole dance of unregistering + re-registering the
>> opregion seems unnecessary. You already have ish_link_ready in case the
>> opregion gets called before things are ready; and if the opregion is called
>> when the link is not ready, still having the opregion handler in place allows
>> you to log a sensible error about what is going on which is what we want.
> 
> Initial approach was same as you suggested ( No uninstall, just wait in ACPI
> Method). But after every resume, the driver gets ACPI write and read requests
> for FAN and thermal controls which fails  because link is not ready. Also we 
> can't wait_event_interruptible_timeout() in ACPI method until we get the 
> link_ready( link can become ready much later until PSE fully boots up after every
> Sx. Anything else gets executed after this wait_event timeout fail in ACPI method.
> We can't afford to miss any critical thermal/FAN related setting from standby/
> hibernation resume. No requests are missed by registering opregion only after
> link_ready.

I see; and since the OpRegion API does not allow returning a status code to
communicate the link-not-ready thing you need to do this unregister + re-register
dance instead. See this is what I meant above when I wrote that the whole OpRegion
API seems lacking. This could all have been solved by having the OpRegion calls
communicate back a status code.

Now you are relying on communicating the availability of the link by calling
_REG instead. This means that we better hope that all users of the OpRegion will
correctly check the flag set by _REG, which in my experience with a lot of AML
code is something which is often forgotten, so this will be another source
of DSDT/AML bugs for AML code using this OpRegion <sigh>.

Also note that this is racy too, on suspend we unregister the OpRegion, calling
_REG in the process. But _REG methods typically are not Serialized so now the
following may happen:

1. Thread A is executing a function using the EClite OpRegion
2. Thread A checks the flag set by _REG, sees the region is available
3. Thread B is executing suspend for the EClite device, unregister the
   OpRegion, calling _REG to clear the flag
4. Thread A continues with actually accessing the no longer available
   OPRegion leading to an error because there is no Opregion handler
   registered.

So this means that _REG should be marked Serialized for this device,
I wonder if it actually is marked as such in the DSDT of your test hardware ?

I think we might get away with this regardless because 3 probably takes a
rw-lock on the ACPI namespace which it can only get if no other threads
are executing any AML code (I'm speculating here I did not check), but this
is yet another example about how this entire approach is less then ideal.

<snip>

>>> +static void ecl_ishtp_cl_deinit(struct ishtp_cl *ecl_ishtp_cl) {
>>> +	ishtp_cl_unlink(ecl_ishtp_cl);
>>> +	ishtp_cl_flush_queues(ecl_ishtp_cl);
>>> +	ishtp_cl_free(ecl_ishtp_cl);
>>> +}
>>> +
>>> +static void ecl_ishtp_cl_reset_handler(struct work_struct *work) {
>>> +	struct ishtp_opregion_dev *opr_dev;
>>> +	struct ishtp_cl_device *cl_device;
>>> +	struct ishtp_cl *ecl_ishtp_cl;
>>> +	int rv;
>>> +	int retry;
>>> +
>>> +	opr_dev = container_of(work, struct ishtp_opregion_dev,
>> reset_work);
>>> +
>>> +	opr_dev->ish_link_ready = false;
>>> +
>>> +	cl_device = opr_dev->cl_device;
>>> +	ecl_ishtp_cl = opr_dev->ecl_ishtp_cl;
>>> +
>>> +	ecl_ishtp_cl_deinit(ecl_ishtp_cl);
>>> +
>>> +	ecl_ishtp_cl = ishtp_cl_allocate(cl_device);
>>> +	if (!ecl_ishtp_cl)
>>> +		return;
>>
>> Is this whole freeing + re-alloc of the ISHTP client here really necessary ? This
>> seems like overkill.
> 
> This is required. reset is an asynchronous notification from ISH
> (PSE in this case) firmware and current connection becomes stale and needs
> to be reinitialized. All ISHTP client drivers are implemented same way. 
> eg.
> drivers/hid/intel-ish-hid/ishtp-hid-client.c
> drivers/hid/intel-ish-hid/ishtp-fw-loader.c

Ok.

<snip>

>>> +static int ecl_ishtp_cl_probe(struct ishtp_cl_device *cl_device) {
>>> +	struct ishtp_cl *ecl_ishtp_cl;
>>> +	struct ishtp_opregion_dev *opr_dev;
>>> +	int rv;
>>> +
>>> +	opr_dev = devm_kzalloc(ishtp_device(cl_device), sizeof(*opr_dev),
>>> +			       GFP_KERNEL);
>>> +	if (!opr_dev)
>>> +		return -ENOMEM;
>>> +
>>> +	ecl_ishtp_cl = ishtp_cl_allocate(cl_device);
>>> +	if (!ecl_ishtp_cl)
>>> +		return -ENOMEM;
>>> +
>>> +	ishtp_set_drvdata(cl_device, ecl_ishtp_cl);
>>> +	ishtp_set_client_data(ecl_ishtp_cl, opr_dev);
>>> +	opr_dev->ecl_ishtp_cl = ecl_ishtp_cl;
>>> +	opr_dev->cl_device = cl_device;
>>> +
>>> +	init_waitqueue_head(&opr_dev->read_wait);
>>> +	INIT_WORK(&opr_dev->event_work, ecl_acpi_invoke_dsm);
>>> +	INIT_WORK(&opr_dev->reset_work, ecl_ishtp_cl_reset_handler);
>>> +
>>> +	/* Initialize ish client device */
>>> +	rv = ecl_ishtp_cl_init(ecl_ishtp_cl);
>>> +	if (rv) {
>>> +		dev_err(cl_data_to_dev(opr_dev), "Client init failed\n");
>>> +		goto err_exit;
>>> +	}
>>> +
>>> +	dev_dbg(cl_data_to_dev(opr_dev), "eclite-ishtp client
>>> +initialised\n");
>>> +
>>> +	/* Register a handler for eclite fw events */
>>> +	ishtp_register_event_cb(cl_device, ecl_ishtp_cl_event_cb);
>>> +
>>> +	ishtp_get_device(cl_device);
>>
>> This seems weird, normally in the device-model a driver being bound to a
>> device guarantees that that device cannot go away before the remove
>> callback of the driver is called.
>>
>> So it seems to me that this call + the put in both the err_exit and
>> ecl_ishtp_cl_remove() cases can be dropped.
>>
> This platform driver has two interfaces - a)ISH and b)ACPI.
> ISH initializes first and if successful we ishtp_get_device().
> Then ACPI initializes after that. If ACPI init fails, driver gets cleaned with
> ISHTP as well thus ishtp_get_device() in probe's err_exit. Both interface must be
> Required and initialized for the functionality.
> 
> Do you still see a problem?

I don't see a problem, but I don't think that the ishtp_get_device() here
and the 2 ishtp_put_device() calls below are necessary.

This is the probe function for a ishtp_cl_driver as long as that driver
is bound to the cl_device (which gets passed as parameter to the probe())
the cl_device can never go away, not until the matching remove function
from the ishtp_cl_driver has been called, so the get at probe + the put
at remove are not necessary, since the cl_device already must stick
around for as long as the driver is bound.

Another way of looking at this is that the linux device-model/driver core
already does a get when it binds a driver to the device (and a put on
remove).


>>> +
>>> +	opr_dev->ish_link_ready = true;
>>> +
>>> +	/* Now find ACPI device and init opregion handlers */
>>> +	rv = acpi_opregion_init(opr_dev);
>>> +	if (rv) {
>>> +		dev_err(cl_data_to_dev(opr_dev), "ACPI opregion init
>> failed\n");
>>> +
>>> +		goto err_exit;
>>> +	}
>>> +
>>> +	/* Reprobe devices depending on ECLite - battery, fan, etc. */
>>> +	acpi_walk_dep_device_list(opr_dev->acpi_handle);
>>> +
>>> +	return 0;
>>> +err_exit:
>>> +	ishtp_set_connection_state(ecl_ishtp_cl,
>> ISHTP_CL_DISCONNECTING);
>>> +	ishtp_cl_disconnect(ecl_ishtp_cl);
>>> +	ecl_ishtp_cl_deinit(ecl_ishtp_cl);
>>> +
>>> +	ishtp_put_device(cl_device);
>>> +
>>> +	return rv;
>>> +}
>>> +
>>> +static int ecl_ishtp_cl_remove(struct ishtp_cl_device *cl_device) {
>>> +	struct ishtp_cl *ecl_ishtp_cl = ishtp_get_drvdata(cl_device);
>>> +	struct ishtp_opregion_dev *opr_dev =
>>> +		ishtp_get_client_data(ecl_ishtp_cl);
>>> +
>>> +	if (opr_dev->acpi_init_done)
>>> +		acpi_opregion_deinit(opr_dev);
>>> +
>>> +	cancel_work_sync(&opr_dev->reset_work);
>>> +	cancel_work_sync(&opr_dev->event_work);
>>> +
>>> +	ishtp_set_connection_state(ecl_ishtp_cl,
>> ISHTP_CL_DISCONNECTING);
>>> +	ishtp_cl_disconnect(ecl_ishtp_cl);
>>> +	ecl_ishtp_cl_deinit(ecl_ishtp_cl);
>>> +
>>> +	ishtp_put_device(cl_device);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ecl_ishtp_cl_reset(struct ishtp_cl_device *cl_device) {
>>> +	struct ishtp_cl *ecl_ishtp_cl = ishtp_get_drvdata(cl_device);
>>> +	struct ishtp_opregion_dev *opr_dev =
>>> +		ishtp_get_client_data(ecl_ishtp_cl);
>>> +
>>> +	schedule_work(&opr_dev->reset_work);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ecl_ishtp_cl_suspend(struct device *device) {
>>> +	struct ishtp_cl_device *cl_device = ishtp_dev_to_cl_device(device);
>>> +	struct ishtp_cl *ecl_ishtp_cl = ishtp_get_drvdata(cl_device);
>>> +	struct ishtp_opregion_dev *opr_dev =
>>> +		ishtp_get_client_data(ecl_ishtp_cl);
>>> +
>>> +	if (acpi_target_system_state() == ACPI_STATE_S0)
>>> +		return 0;
>>> +
>>> +	acpi_opregion_deinit(opr_dev);
>>> +	ecl_ish_cl_enable_events(opr_dev, false);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ecl_ishtp_cl_resume(struct device *device) {
>>> +	/* A reset is expected to call after an Sx. At this point
>>> +	 * we are not sure if the link is up or not to restore anything,
>>> +	 * so do nothing in resume path
>>> +	 */
>>> +	return 0;
>>
>> This seems very wrong, this means that there are no resume ordering
>> guarantees meaning that drivers which are ordered to resume after this
>> driver, because they rely on the opregion may end up not being able to use
>> the opregion leading to all kind of issues.
>>
>> IMHO what should happen here is that this driver waits for the EClite to
>> become ready here. Which probably means that it itself should be only
>> resumed after the ISH HID driver is, but I assume that the ISH device is a
>> parent of this device, so that ordering should be correct automatically.
> 
>>
>> TBH the whole lets just not resume and do a reset instead and then just
>> tearing down the entire ISHTP client struct and setting up a new one from
>> scratch, just feels very wrong.  At a minimum the teardown + bringup needs
>> to happen before the resume callback completes, but ideally this would be
>> replaced by a much lighter resume solution.
> 
> ISH Firmware (the PSE subsystem) can boot up/reinitialize Every Sx based on
> usecase or sometimes PSE is always-on. So the resume path is asynchronous 
> and unpredictable in this case. Re-initialization and clean up required if PSE
> also boot up every Sx and might take good amount of time (Host can come alive
> before PSE comes up). Thus using asynchronous reset notification. 

Ok, so I guess we need to live with the ugly deregister + re-register
OpRegion dance for the devices where the PSE is shutdown during suspend.

You also write: "sometimes PSE is always-on", what about that case,
I assume in this case there will be no reset after resume? So then
unregistering the OpRegion handler at suspend (and setting link_ready=false)
will be wrong since without the reset the OpRegion handler will never
get reinstalled ?

Regards,

Hans

