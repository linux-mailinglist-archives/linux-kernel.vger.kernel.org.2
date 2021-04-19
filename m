Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC5364B41
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 22:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbhDSUjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 16:39:51 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:14514 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239244AbhDSUjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 16:39:47 -0400
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JKYqB6024443;
        Mon, 19 Apr 2021 20:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=bfKFEUkYdyXgz1kyEDvOgJQPLd2DbiMBbNI61ZASQI4=;
 b=ONjhimyT10nm8WsH9SDjjO6e7fhh5NX9BGdc30Wh1N5Ij4WKrerzFyYpxAUd2aVNdTbL
 1fKHNZhgTw43HAxBmsb99XFPmQqNEvBXGZ1zKedYA+THev9Pmvsrf3ic64fFl9uWk+Zo
 UHRTcv/SuvbRy05trRFHKa1D2SOS+euXArjlp4iLHQVT6Js7ky0gnIxN4V4QlnORrpGz
 G57zLHbCP6E33VdRZuB4qU519LuxmOaK0esGCzf3+xcDgOZQsM/uei/RV7f10kPCOTS5
 mOZUkr0HQKjR6DsELvGvQydsHq5S5ixF2pqVsngJLzKU/c1fOJ+7Iq09bQh6eTrz+AVW cA== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 381e7wh7e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 20:38:41 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 1425B6C;
        Mon, 19 Apr 2021 20:38:41 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.212.148])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 4730746;
        Mon, 19 Apr 2021 20:38:39 +0000 (UTC)
Date:   Mon, 19 Apr 2021 15:38:38 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, acme@kernel.org,
        andreas@oehler-net.de, eranian@google.com, osk@google.com,
        tglx@linutronix.de, mark@voidzero.net, steve.wahl@hpe.com
Subject: Re: [PATCH] perf/x86/intel/uncore: Remove uncore extra PCI dev
 HSWEP_PCI_PCU_3
Message-ID: <YH3qTmPFrQ7oXtP4@swahl-home.5wahls.com>
References: <1618521764-100923-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618521764-100923-1-git-send-email-kan.liang@linux.intel.com>
X-Proofpoint-GUID: yAc7h2HfCfPOvtXmtkadEFTWCiWz9ZS0
X-Proofpoint-ORIG-GUID: yAc7h2HfCfPOvtXmtkadEFTWCiWz9ZS0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_11:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190141
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Steve Wahl <steve.wahl@hpe.com>

On Thu, Apr 15, 2021 at 02:22:43PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> There may be a kernel panic on the Haswell server and the Broadwell
> server, if the snbep_pci2phy_map_init() return error.
> 
> The uncore_extra_pci_dev[HSWEP_PCI_PCU_3] is used in the cpu_init() to
> detect the existence of the SBOX, which is a MSR type of PMON unit.
> The uncore_extra_pci_dev is allocated in the uncore_pci_init(). If the
> snbep_pci2phy_map_init() returns error, perf doesn't initialize the
> PCI type of the PMON units, so the uncore_extra_pci_dev will not be
> allocated. But perf may continue initializing the MSR type of PMON
> units. A null dereference kernel panic will be triggered.
> 
> The sockets in a Haswell server or a Broadwell server are identical.
> Only need to detect the existence of the SBOX once.
> Current perf probes all available PCU devices and stores them into the
> uncore_extra_pci_dev. It's unnecessary.
> Use the pci_get_device() to replace the uncore_extra_pci_dev. Only
> detect the existence of the SBOX on the first available PCU device once.
> 
> Factor out hswep_has_limit_sbox(), since the Haswell server and the
> Broadwell server uses the same way to detect the existence of the SBOX.
> 
> Add some macros to replace the magic number.
> 
> Fixes: 5306c31c5733 ("perf/x86/uncore/hsw-ep: Handle systems with only two SBOXes")
> Reported-by: Steve Wahl <steve.wahl@hpe.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 61 +++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index b79951d..9b89376 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -1159,7 +1159,6 @@ enum {
>  	SNBEP_PCI_QPI_PORT0_FILTER,
>  	SNBEP_PCI_QPI_PORT1_FILTER,
>  	BDX_PCI_QPI_PORT2_FILTER,
> -	HSWEP_PCI_PCU_3,
>  };
>  
>  static int snbep_qpi_hw_config(struct intel_uncore_box *box, struct perf_event *event)
> @@ -2857,22 +2856,33 @@ static struct intel_uncore_type *hswep_msr_uncores[] = {
>  	NULL,
>  };
>  
> -void hswep_uncore_cpu_init(void)
> +#define HSWEP_PCU_DID			0x2fc0
> +#define HSWEP_PCU_CAPID4_OFFET		0x94
> +#define hswep_get_chop(_cap)		(((_cap) >> 6) & 0x3)
> +
> +static bool hswep_has_limit_sbox(unsigned int device)
>  {
> -	int pkg = boot_cpu_data.logical_proc_id;
> +	struct pci_dev *dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, NULL);
> +	u32 capid4;
> +
> +	if (!dev)
> +		return false;
> +
> +	pci_read_config_dword(dev, HSWEP_PCU_CAPID4_OFFET, &capid4);
> +	if (!hswep_get_chop(capid4))
> +		return true;
>  
> +	return false;
> +}
> +
> +void hswep_uncore_cpu_init(void)
> +{
>  	if (hswep_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
>  		hswep_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
>  
>  	/* Detect 6-8 core systems with only two SBOXes */
> -	if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
> -		u32 capid4;
> -
> -		pci_read_config_dword(uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3],
> -				      0x94, &capid4);
> -		if (((capid4 >> 6) & 0x3) == 0)
> -			hswep_uncore_sbox.num_boxes = 2;
> -	}
> +	if (hswep_has_limit_sbox(HSWEP_PCU_DID))
> +		hswep_uncore_sbox.num_boxes = 2;
>  
>  	uncore_msr_uncores = hswep_msr_uncores;
>  }
> @@ -3135,11 +3145,6 @@ static const struct pci_device_id hswep_uncore_pci_ids[] = {
>  		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
>  						   SNBEP_PCI_QPI_PORT1_FILTER),
>  	},
> -	{ /* PCU.3 (for Capability registers) */
> -		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2fc0),
> -		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
> -						   HSWEP_PCI_PCU_3),
> -	},
>  	{ /* end: all zeroes */ }
>  };
>  
> @@ -3231,27 +3236,18 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
>  	EVENT_CONSTRAINT_END
>  };
>  
> +#define BDX_PCU_DID			0x6fc0
> +
>  void bdx_uncore_cpu_init(void)
>  {
> -	int pkg = topology_phys_to_logical_pkg(boot_cpu_data.phys_proc_id);
> -
>  	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
>  		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
>  	uncore_msr_uncores = bdx_msr_uncores;
>  
> -	/* BDX-DE doesn't have SBOX */
> -	if (boot_cpu_data.x86_model == 86) {
> -		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
>  	/* Detect systems with no SBOXes */
> -	} else if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
> -		struct pci_dev *pdev;
> -		u32 capid4;
> -
> -		pdev = uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3];
> -		pci_read_config_dword(pdev, 0x94, &capid4);
> -		if (((capid4 >> 6) & 0x3) == 0)
> -			bdx_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
> -	}
> +	if ((boot_cpu_data.x86_model == 86) || hswep_has_limit_sbox(BDX_PCU_DID))
> +		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
> +
>  	hswep_uncore_pcu.constraints = bdx_uncore_pcu_constraints;
>  }
>  
> @@ -3472,11 +3468,6 @@ static const struct pci_device_id bdx_uncore_pci_ids[] = {
>  		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
>  						   BDX_PCI_QPI_PORT2_FILTER),
>  	},
> -	{ /* PCU.3 (for Capability registers) */
> -		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
> -		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
> -						   HSWEP_PCI_PCU_3),
> -	},
>  	{ /* end: all zeroes */ }
>  };
>  
> -- 
> 2.7.4
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
