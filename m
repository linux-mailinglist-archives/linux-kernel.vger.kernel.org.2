Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C63C372961
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 13:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhEDLCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 07:02:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39460 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhEDLB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 07:01:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144B0MCh015649;
        Tue, 4 May 2021 11:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=A8A/MEZAfIUq5ek6GA0vAFt2GbsWCmOkRFAI81gbMbo=;
 b=fly/P9UR2zqn6ztQqArGhqW1Yv/0e/EMD7bwz2STeJb1t1RnXg4Ql6mObOALhunxvarM
 u3v29ybTPjeQdkaQ7hQeRRlGRqMNEMLaisC48AODvzXyofz5yqR4G4ROoyjpDQLHclGz
 ss0KtPjwggwp8tmEJaoLXY8zPV1aHey0W4c5CuadPzeEYEdnw8zOH4NTIiq9nQXh/5EB
 +CTzVSfhdZEmW2n4Wu68rPJKKBOqrOyJ5AWN+WZ2eag8YWTZUlCmwh3SJaKFN1y/siJk
 bPsLWIJR04C+JGFKwKhAeuOx8qH8vQkAbwT0YaFvJ0Nk1ymFzLCSeEA1PvbcDDIsK0Sg dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 388xxmxg41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 11:00:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144AtMZj009310;
        Tue, 4 May 2021 11:00:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 389grrvqbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 11:00:21 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 144AuSMZ012641;
        Tue, 4 May 2021 11:00:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 389grrvqb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 11:00:21 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 144B09jD003618;
        Tue, 4 May 2021 11:00:17 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 May 2021 04:00:09 -0700
Date:   Tue, 4 May 2021 14:00:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v6] staging: unisys: visorhba: Convert module from IDR to
 XArray
Message-ID: <20210504110001.GV1981@kadam>
References: <20210504100744.28073-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504100744.28073-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: NIdlyiNCEtYwzGMadn8TM5aHsJ_RkzAw
X-Proofpoint-ORIG-GUID: NIdlyiNCEtYwzGMadn8TM5aHsJ_RkzAw
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 12:07:44PM +0200, Fabio M. De Francesco wrote:
> -static void setup_scsitaskmgmt_handles(struct idr *idrtable, spinlock_t *lock,
> -				       struct uiscmdrsp *cmdrsp,
> +static int setup_scsitaskmgmt_handles(struct xarray *xa, struct uiscmdrsp *cmdrsp,
>  				       wait_queue_head_t *event, int *result)
>  {
> -	/* specify the event that has to be triggered when this */
> -	/* cmd is complete */
> -	cmdrsp->scsitaskmgmt.notify_handle =
> -		simple_idr_get(idrtable, event, lock);
> -	cmdrsp->scsitaskmgmt.notifyresult_handle =
> -		simple_idr_get(idrtable, result, lock);
> +	int ret;
> +	u32 id;
> +
> +	/* specify the event that has to be triggered when this cmd is complete */
> +	ret = xa_alloc_irq(xa, &id, event, xa_limit_32b, GFP_KERNEL);
> +	if (ret == 0)
> +		cmdrsp->scsitaskmgmt.notify_handle = id;
> +	else
> +		return ret;

Reverse the condition.  Always do error handling, not success handling.
Try keep the success path at one tab indent and the failure path at two
tab indents.

	ret = xa_alloc_irq(xa, &id, event, xa_limit_32b, GFP_KERNEL);
	if (ret)
		return ret;
	cmdrsp->scsitaskmgmt.notify_handle = id;

	ret = xa_alloc_irq(xa, &id, result, xa_limit_32b, GFP_KERNEL);
	if (ret) {
		xa_erase(xa, cmdrsp->scsitaskmgmt.notify_handle);
		return ret;
	}
	cmdrsp->scsitaskmgmt.notifyresult_handle = id;


> +
> +	ret = xa_alloc_irq(xa, &id, result, xa_limit_32b, GFP_KERNEL);
> +	if (ret == 0)
> +		cmdrsp->scsitaskmgmt.notifyresult_handle = id;
> +	else {
> +		xa_erase(xa, cmdrsp->scsitaskmgmt.notify_handle);
> +		return ret;
> +	}
> +
> +	return ret;

	return 0;

>  }
>  
>  /*
>   * cleanup_scsitaskmgmt_handles - Forget handles created by
>   *				  setup_scsitaskmgmt_handles()
> - * @idrtable: The data object maintaining the pointer<-->int mappings
> + * @xa: The data object maintaining the pointer<-->int mappings
>   * @cmdrsp:   Response from the IOVM
>   */
> -static void cleanup_scsitaskmgmt_handles(struct idr *idrtable,
> +static void cleanup_scsitaskmgmt_handles(struct xarray *xa,
>  					 struct uiscmdrsp *cmdrsp)
>  {
> -	if (cmdrsp->scsitaskmgmt.notify_handle)
> -		idr_remove(idrtable, cmdrsp->scsitaskmgmt.notify_handle);
> -	if (cmdrsp->scsitaskmgmt.notifyresult_handle)
> -		idr_remove(idrtable, cmdrsp->scsitaskmgmt.notifyresult_handle);
> +	xa_erase(xa, cmdrsp->scsitaskmgmt.notify_handle);
> +	xa_erase(xa, cmdrsp->scsitaskmgmt.notifyresult_handle);
>  }
>  
>  /*
> @@ -269,6 +249,7 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
>  	int notifyresult = 0xffff;
>  	wait_queue_head_t notifyevent;
>  	int scsicmd_id;
> +	int setup_ret;

This should be "int ret;".  Don't be fancy with the names.

>  
>  	if (devdata->serverdown || devdata->serverchangingstate)
>  		return FAILED;
> @@ -284,8 +265,16 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
>  
>  	/* issue TASK_MGMT_ABORT_TASK */
>  	cmdrsp->cmdtype = CMD_SCSITASKMGMT_TYPE;
> -	setup_scsitaskmgmt_handles(&devdata->idr, &devdata->privlock, cmdrsp,
> +
> +	setup_ret = setup_scsitaskmgmt_handles(&devdata->xa, cmdrsp,
>  				   &notifyevent, &notifyresult);
> +	if (setup_ret < 0) {

You changed setup_scsitaskmgmt_handles() to return non-zero on error so
check for non-zero here.  Be consistent.

	if (ret)
		return FAILED;


> +		dev_dbg(&scsidev->sdev_gendev,
> +		        "visorhba: setup_scsitaskmgmt_handles returned %d\n",
> +			setup_ret);
> +		return FAILED;
> +	}
> +
>  
>  	/* save destination */
>  	cmdrsp->scsitaskmgmt.tasktype = tasktype;
> @@ -311,14 +300,14 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
>  	dev_dbg(&scsidev->sdev_gendev,
>  		"visorhba: taskmgmt type=%d success; result=0x%x\n",
>  		 tasktype, notifyresult);
> -	cleanup_scsitaskmgmt_handles(&devdata->idr, cmdrsp);
> +	cleanup_scsitaskmgmt_handles(&devdata->xa, cmdrsp);
>  	return SUCCESS;
>  
>  err_del_scsipending_ent:
>  	dev_dbg(&scsidev->sdev_gendev,
>  		"visorhba: taskmgmt type=%d not executed\n", tasktype);
>  	del_scsipending_ent(devdata, scsicmd_id);
> -	cleanup_scsitaskmgmt_handles(&devdata->idr, cmdrsp);
> +	cleanup_scsitaskmgmt_handles(&devdata->xa, cmdrsp);
>  	return FAILED;
>  }
>  
> @@ -654,13 +643,13 @@ DEFINE_SHOW_ATTRIBUTE(info_debugfs);
>   * Service Partition returned the result of the task management
>   * command. Wake up anyone waiting for it.
>   */
> -static void complete_taskmgmt_command(struct idr *idrtable,
> +static void complete_taskmgmt_command(struct xarray *xa,
>  				      struct uiscmdrsp *cmdrsp, int result)
>  {
>  	wait_queue_head_t *wq =
> -		idr_find(idrtable, cmdrsp->scsitaskmgmt.notify_handle);
> +		xa_load(xa, cmdrsp->scsitaskmgmt.notify_handle);
>  	int *scsi_result_ptr =
> -		idr_find(idrtable, cmdrsp->scsitaskmgmt.notifyresult_handle);
> +		xa_load(xa, cmdrsp->scsitaskmgmt.notifyresult_handle);
>  	if (unlikely(!(wq && scsi_result_ptr))) {
>  		pr_err("visorhba: no completion context; cmd will time out\n");
>  		return;
> @@ -708,7 +697,7 @@ static void visorhba_serverdown_complete(struct visorhba_devdata *devdata)
>  			break;
>  		case CMD_SCSITASKMGMT_TYPE:
>  			cmdrsp = pendingdel->sent;
> -			complete_taskmgmt_command(&devdata->idr, cmdrsp,
> +			complete_taskmgmt_command(&devdata->xa, cmdrsp,
>  						  TASK_MGMT_FAILED);
>  			break;
>  		default:
> @@ -905,7 +894,7 @@ static void drain_queue(struct uiscmdrsp *cmdrsp,
>  			if (!del_scsipending_ent(devdata,
>  						 cmdrsp->scsitaskmgmt.handle))
>  				break;
> -			complete_taskmgmt_command(&devdata->idr, cmdrsp,
> +			complete_taskmgmt_command(&devdata->xa, cmdrsp,
>  						  cmdrsp->scsitaskmgmt.result);
>  		} else if (cmdrsp->cmdtype == CMD_NOTIFYGUEST_TYPE)
>  			dev_err_once(&devdata->dev->device,
> @@ -1053,7 +1042,7 @@ static int visorhba_probe(struct visor_device *dev)
>  	if (err)
>  		goto err_debugfs_info;
>  
> -	idr_init(&devdata->idr);
> +	xa_init(&devdata->xa);
>  
>  	devdata->cmdrsp = kmalloc(sizeof(*devdata->cmdrsp), GFP_ATOMIC);
>  	visorbus_enable_channel_interrupts(dev);
> @@ -1096,8 +1085,6 @@ static void visorhba_remove(struct visor_device *dev)
>  	scsi_remove_host(scsihost);
>  	scsi_host_put(scsihost);
>  
> -	idr_destroy(&devdata->idr);

Do we not have to call xa_destroy()?

> -
>  	dev_set_drvdata(&dev->device, NULL);
>  	debugfs_remove(devdata->debugfs_info);
>  	debugfs_remove_recursive(devdata->debugfs_dir);

regards,
dan carpenter

