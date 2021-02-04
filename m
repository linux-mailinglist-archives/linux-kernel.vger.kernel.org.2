Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D4830F067
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbhBDKU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:20:29 -0500
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:41861 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231244AbhBDKUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:20:24 -0500
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 7bjalHRIBW4yN7bjdlc377; Thu, 04 Feb 2021 11:19:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1612433980; bh=rNgoJgbHD7TTIu0rLfFdDvFg5hk3GBBsYt265YMiUgs=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=Iwyb+wP+J+s1F1mi2rLxtZfqYYM1Xir+ayJ0Dnr5ZG2ffGT20up8gV1Uaue8X6Wv2
         IaftSAQQpK/m/UunW1W22JsnQZtzRlbziDu1cVKlAdfgPMztMLRo/08CwsQn4UDX5U
         kfN5HsLI0iB1NREIUKrQz3SclV+AcjT5dpOJKMgVpeeQOqniqEYTwaPO98sgrbv+g1
         gHs1JVy4MlVv/PGGaNpFmxkvYido3atEIqanr24hzecbOsrzimTQSECFy4NfEngVTI
         p/HMujXmTfaETVxa1fUYABwqAxNgAof+coBx7I2ijiDGIDNomDSjN6GMPZl09vRz7M
         mpPnd4PYeSIwQ==
Subject: Re: [PATCH v3 2/4] drm_dp_mst_topology: use correct AUX channel
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Sam McNally <sammc@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        dri-devel@lists.freedesktop.org
References: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
 <20200923121320.v3.2.Ided0ab0808c4908238bd2eb9ebb6ffb2c9312789@changeid>
 <YBh9HvbIRF4zd+AK@intel.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <2a7c2edc-b83c-dccf-487d-1415b4bc23ff@xs4all.nl>
Date:   Thu, 4 Feb 2021 11:19:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBh9HvbIRF4zd+AK@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJIAEhcGV8870J9oblZUYSUzZcvQeLy+fIP6P1UDWwpeh7ycXqMz/ikMNP2SR6gwVq5zuCqdeH7tILOMTt/F1OyBrV8O7jhdOCdtrt3fJ0zx9qoQW2Wb
 C9nPYYbu4/6zSXgt4vy49CWqQpQYmgylz/r4Oup2Ba2c4p82Epa/LNuh7+P1uTBwm4/R1QwiNHtuh3TtJ1QsJE54ueda+BLQLuYTylaXuVHvN8OB3GA1eUs6
 pJDo2Sesm44mteX2MMrA3G0dpse1g+DA/klIlh+HFSSKCJR8Y20H+jhnATQOOIW+3c55XtXU0ZraNNltsJzkcAd6tHDcn86B3ZEzwGL55u+ABgdNc3AXeaXk
 iewyj0dC8PYMZQamurpbqZbmqTZmQLazWbF70BDT2oTAcLH1CeJbJBhyGFHFkfVOo+q8WrHm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2021 23:13, Ville Syrjälä wrote:
> On Wed, Sep 23, 2020 at 12:13:53PM +1000, Sam McNally wrote:
>> From: Hans Verkuil <hans.verkuil@cisco.com>
>>
>> For adapters behind an MST hub use the correct AUX channel.
>>
>> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
>> [sammc@chromium.org: rebased, removing redundant changes]
>> Signed-off-by: Sam McNally <sammc@chromium.org>
>> ---
>>
>> (no changes since v1)
>>
>>  drivers/gpu/drm/drm_dp_mst_topology.c | 36 +++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
>> index 15b6cc39a754..0d753201adbd 100644
>> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
>> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
>> @@ -2255,6 +2255,9 @@ drm_dp_mst_topology_unlink_port(struct drm_dp_mst_topology_mgr *mgr,
>>  	drm_dp_mst_topology_put_port(port);
>>  }
>>  
>> +static ssize_t
>> +drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg);
>> +
>>  static struct drm_dp_mst_port *
>>  drm_dp_mst_add_port(struct drm_device *dev,
>>  		    struct drm_dp_mst_topology_mgr *mgr,
>> @@ -2271,9 +2274,13 @@ drm_dp_mst_add_port(struct drm_device *dev,
>>  	port->port_num = port_number;
>>  	port->mgr = mgr;
>>  	port->aux.name = "DPMST";
>> +	mutex_init(&port->aux.hw_mutex);
>> +	mutex_init(&port->aux.cec.lock);
>>  	port->aux.dev = dev->dev;
>>  	port->aux.is_remote = true;
>>  
>> +	port->aux.transfer = drm_dp_mst_aux_transfer;
>> +
> 
> This was supposed to be handled via higher levels checking for
> is_remote==true.

Ah, I suspect this patch can be dropped entirely: it predates commit 2f221a5efed4
("drm/dp_mst: Add MST support to DP DPCD R/W functions").

It looks like that commit basically solved what this older patch attempts to do
as well.

Sam, can you test if it works without this patch?

Regards,

	Hans

> 
>>  	/* initialize the MST downstream port's AUX crc work queue */
>>  	drm_dp_remote_aux_init(&port->aux);
>>  
>> @@ -3503,6 +3510,35 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
>>  	return 0;
>>  }
>>  
>> +static ssize_t
>> +drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
>> +{
>> +	struct drm_dp_mst_port *port =
>> +		container_of(aux, struct drm_dp_mst_port, aux);
>> +	int ret;
>> +
>> +	switch (msg->request & ~DP_AUX_I2C_MOT) {
>> +	case DP_AUX_NATIVE_WRITE:
>> +	case DP_AUX_I2C_WRITE:
>> +	case DP_AUX_I2C_WRITE_STATUS_UPDATE:
>> +		ret = drm_dp_send_dpcd_write(port->mgr, port, msg->address,
>> +					     msg->size, msg->buffer);
> 
> That doesn't make sense to me. I2c writes and DPCD writes
> are definitely not the same thing.
> 
> aux->transfer is a very low level thing. I don't think it's the
> correct level of abstraction for sideband.
> 
>> +		break;
>> +
>> +	case DP_AUX_NATIVE_READ:
>> +	case DP_AUX_I2C_READ:
>> +		ret = drm_dp_send_dpcd_read(port->mgr, port, msg->address,
>> +					    msg->size, msg->buffer);
>> +		break;
>> +
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  static int drm_dp_get_vc_payload_bw(u8 dp_link_bw, u8  dp_link_count)
>>  {
>>  	if (dp_link_bw == 0 || dp_link_count == 0)
>> -- 
>> 2.28.0.681.g6f77f65b4e-goog
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

